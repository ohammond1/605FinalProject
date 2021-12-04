n = 100000
skip = 1
file = "wsb_comments_raw.csv"



for(i in (1:5)){
  wsb <- read.csv(file = file, nrows = n, skip = skip, header = FALSE, col.names = wsb.col)
  newwsb = wsb[,c('id','subreddit_id','body','created_utc')]
  print(head(newwsb))
  skip = skip + n
  write.csv(newwsb, paste("wsb",i,".csv", sep = ''))
}


#This works
head(read.csv(file = file, nrows = n, skip = 10000, header = FALSE, col.names = wsb.col))

#This breaks somewhere between lines 100,000 and 200,000
head(read.csv(file = file, nrows = n, skip = 1000000, header = FALSE, col.names = wsb.col))


read.csv(file,nrows=1,skip = skip)
head(read.csv(file = file, nrows = n, skip = 1000000, header = FALSE, col.names = wsb.col))
wsb <- read.csv("wsb_comments_raw.csv", nrows = 100000 )
newwsb = wsb[c('id','subreddit_id','body','created_utc')]
write.csv(newwsb, "miniwsb.csv")

#setwd("/Users/maritmcquaig/Documents/Stat605/project/")
