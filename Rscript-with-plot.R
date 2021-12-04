library(tidyverse)
library(lubridate)
library(sentimentr)

#setwd("C:/Users/Jake reiners/Documents")
data <- data.table::fread("miniwsb.csv")
## mutate the utc into a day.
data <- data %>% mutate( , day = as.Date(as_datetime(data$created_utc)), ) 

sentiment_scores <- with(data, sentiment_by(get_sentences(body), list(day)))



by_date <- data %>% group_by(day) %>% summarise(, day_count = n())
# adding the sentiment score to the data frame with easier to interpret dates
by_date <- by_date %>% mutate(sentiment = sentiment_scores$ave_sentiment)
#determining if it's generally positive or negative? 
by_date <- by_date %>% mutate(factor = case_when(sentiment > 0 ~ 1,
                                                sentiment <= 0 ~ -1))
#mostly used for the plotting. 
by_date <- by_date %>% mutate(magnitude = abs(sentiment))

## can use this as a potential frame work for a plot. 
plot <- ggplot( by_date, aes(day, sentiment, color = factor, size = magnitude, alpha = magnitude )) + geom_point()

plot

