require(dplyr)

hist.spy.df <- read.csv("./HistoricalPrices.csv")
hist.spy.df$Date <- as.Date(hist.spy.df$Date, "%m/%d/%y")

hist.spy.df<-hist.spy.df[nrow(hist.spy.df):1,]


close.diff <- diff(as.matrix(hist.spy.df$Close))
close.diff <- rbind(0,close.diff)
hist.spy.df$differential <- close.diff[,1]

wsb.sent.df <- read.csv("./combined_sentiment.csv")
wsb.sent.df$total_sent <- wsb.sent.df$ave_sentiment * wsb.sent.df$day_count
wsb.agg.df <- aggregate(cbind(total_sent, day_count) ~ day, wsb.sent.df, FUN=sum)
wsb.agg.df$day <- as.Date(wsb.agg.df$day)
wsb.agg.df$avg_sent <- wsb.agg.df$total_sent/ wsb.agg.df$day_count

wsb.agg.df <- wsb.agg.df[order(wsb.agg.df$day), ]
combined.df <- merge(wsb.agg.df,hist.spy.df, by.x="day",by.y="Date")

# Calculate Cumulative Sentiment
combined.df$sent_cumsum <- cumsum(combined.df$total_sent)

# Calculate cumulative average sentiment
combined.df$avgsent_cumsum <- cumsum(combined.df$avg_sent)

# Find correlation value
cat(paste("SPY Sentiment Correlation: ",cor(combined.df$avg_sent,combined.df$differential),"\n"))

# See correlation when taking out crazy bit in the between 2020-03-01 and 2020-05-01
combined.sub.df <- combined.df[combined.df$day > as.Date("2020-06-01") | combined.df$day < as.Date("2020-02-01"),]
cat(paste("SPY Sentiment Correlation without Middle: ",cor(combined.sub.df$avg_sent,combined.sub.df$differential),"\n"))

# See correlation when taking a lag of the WSB comments
prior_spy <- hist.spy.df
prior_spy$Date <- prior_spy$Date - 5
combinedprior.df <- merge(wsb.agg.df,prior_spy, by.x="day",by.y="Date")
cat(paste("SPY 5 day Lag Correlation: ", cor(combinedprior.df$avg_sent,combinedprior.df$differential),"\n"))

# See correlation of close and cumulative average sentiment
cat(paste("SPY Close and Cumulative Avg Sentiment Correlation: ",cor(combined.df$avgsent_cumsum,combined.df$Close),"\n"))