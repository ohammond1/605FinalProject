
hist.spy.df <- read.csv("/Users/ohammond/Documents/605/605FinalProject/HistoricalPrices.csv")
hist.spy.df$Date <- as.Date(hist.spy.df$Date, "%m/%d/%y")

hist.spy.df<-hist.spy.df[nrow(hist.spy.df):1,]


close.diff <- diff(as.matrix(hist.spy.df$Close))
close.diff <- rbind(0,close.diff)
hist.spy.df$differential <- close.diff[,1]

wsb.sent.df <- read.csv("/Users/ohammond/Documents/605/605FinalProject/combined_sentiment.csv")
wsb.agg.df <- aggregate(wsb.sent.df, by=(wsb.sent.df$date), FUN=sum)
wsb.agg.df <- wsb.agg.df[order(date), ]
combined.df <- merge(wsb.agg.df,hist.spy.df, by.x="date",by.y="Date")

