library(tidyverse)
library(lubridate)
library(sentimentr)

#setwd("C:/Users/Jake reiners/Documents")
data <- data.table::fread("miniwsb.csv")
## mutate the utc into a day.
data <- data %>% mutate( , day = as.Date(as_datetime(data$created_utc)), ) # need to get it to just return the day. 

sentiment_scores <- with(data, sentiment_by(get_sentences(body), list(day)))

by_date <- data %>% group_by(day) %>% summarise(, day_count = n())
