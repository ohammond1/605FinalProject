wsb <- read.csv("/Users/maritmcquaig/Documents/Stat605/project/wsb_comments_raw.csv", nrows = 100,000)
newwsb = wsb[c('id','subreddit_id','body','created_utc')]
write.csv(newwsb, "miniwsb.csv")