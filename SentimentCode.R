library(dplyr)
library(lubridate)
library(sentimentr)

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 1){
  comment_file = args[1]
  } else {
  cat('usage: Rscript SentimentCode.R <comment csv>', file=stderr())
  stop()
}

#setwd("C:/Users/Jake reiners/Documents")
data <- data.table::fread(comment_file)
cat(toString(head(data)), file=stderr())
## mutate the utc into a day.
#data <- data %>% mutate( , day = as.Date(as_datetime(data$created_utc)), ) # need to get it to just return the day. 
data$day <- as.Date(as_datetime(data$created_utc))

sentiment_scores <- with(data, sentiment_by(get_sentences(body), list(day)))
sentiment_scores$day <- as.Date(sentiment_scores$day,origin="1970-01-01")

cat('sentiment scores calculated', file=stderr())

by_date <- data %>% group_by(day) %>% summarise(day_count = n())

cat('Grouped by date\n', file=stderr())

combined.df <- merge(sentiment_scores,by_date,by.x="day",by.y="day")

outfile <- paste(comment_file,"out",sep=".")
write.csv(combined.df,outfile, row.names=FALSE,quote=FALSE)