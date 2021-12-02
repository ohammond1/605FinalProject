library(tidyverse)
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
## mutate the utc into a day.
data <- data %>% mutate( , day = as.Date(as_datetime(data$created_utc)), ) # need to get it to just return the day. 

sentiment_scores <- with(data, sentiment_by(get_sentences(body), list(day)))
sentiment_scores$day <- as.Date(sentiment_scores$day,origin="1970-01-01")

by_date <- data %>% group_by(day) %>% summarise(, day_count = n())

combined.df <- merge(sentiment_score,by_date,by.x="day",by.y="day")

outfile <- paste(comment_file,"out",sep=".")
write.csv(combined.df,outfile, row.names=FALSE,quote=FALSE)