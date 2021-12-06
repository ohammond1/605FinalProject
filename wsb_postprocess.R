library(ggplot2)
library(dplyr)

hist.spy.df <- read.csv("/Users/ohammond/Documents/605/605FinalProject/HistoricalPrices.csv")
hist.spy.df$Date <- as.Date(hist.spy.df$Date, "%m/%d/%y")

hist.spy.df<-hist.spy.df[nrow(hist.spy.df):1,]


close.diff <- diff(as.matrix(hist.spy.df$Close))
close.diff <- rbind(0,close.diff)
hist.spy.df$differential <- close.diff[,1]

wsb.sent.df <- read.csv("/Users/ohammond/Documents/605/605FinalProject/combined_sentiment.csv")
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
cor(combined.df$avg_sent,combined.df$differential)

# See correlation when taking out crazy bit in the between 2020-03-01 and 2020-05-01
combined.sub.df <- combined.df[combined.df$day > as.Date("2020-06-01") | combined.df$day < as.Date("2020-02-01"),]
cor(combined.sub.df$avg_sent,combined.sub.df$differential)

# See correlation when taking a lag of the WSB comments
prior_spy <- hist.spy.df
prior_spy$Date <- prior5_spy$Date - 5
combinedprior.df <- merge(wsb.agg.df,prior_spy, by.x="day",by.y="Date")
cor(combinedprior.df$avg_sent,combinedprior.df$differential)

# Create Plots broken up to better see comparison
ggplot(combined.df, aes(x=day)) +
  geom_line(aes(y=avg_sent, color='Sentiment')) +
  geom_line(aes(y=differential / 290, color='Differential')) + 
  scale_y_continuous(name="r/wallstreebets Average Sentiment", sec.axis = sec_axis(~.*290,name="SPY $ Differential")) +
  xlab("Date") +
  ggtitle("Average Daily WSB Sentiment Compared to SPY Daily Change") + 
  scale_color_manual("Plot Lines",values = c("Sentiment"="red2","Differential"="blue2")) +
  scale_x_date(date_breaks = "2 month",
               limits = as.Date(c('2020-07-01','2021-02-16'))) +
  theme(legend.position = c(0.12,0.85))
  
 
ggplot(combined.df, aes(x=day)) +
  geom_line(aes(y=avg_sent, color='Sentiment')) +
  geom_line(aes(y=differential / 290, color='Differential')) + 
  scale_y_continuous(name="r/wallstreebets Average Sentiment", sec.axis = sec_axis(~.*290,name="SPY $ Differential")) +
  xlab("Date") +
  ggtitle("Average Daily WSB Sentiment Compared to SPY Daily Change") + 
  scale_color_manual("Plot Lines",values = c("Sentiment"="red2","Differential"="blue2")) +
  scale_x_date(date_breaks = "2 month",
               limits = as.Date(c('2020-01-01','2020-07-01'))) +
  theme(legend.position = c(0.12,0.85))


ggplot(combined.df, aes(x=day)) +
  geom_line(aes(y=avg_sent, color='Sentiment')) +
  geom_line(aes(y=differential / 290, color='Differential')) + 
  scale_y_continuous(name="r/wallstreebets Average Sentiment", sec.axis = sec_axis(~.*290,name="SPY $ Differential")) +
  xlab("Date") +
  ggtitle("Average Daily WSB Sentiment Compared to SPY Daily Change") + 
  scale_color_manual("Plot Lines",values = c("Sentiment"="red2","Differential"="blue2")) +
  scale_x_date(date_breaks = "2 month",
               limits = as.Date(c('2019-07-01','2020-01-01'))) +
  theme(legend.position = c(0.12,0.85))


ggplot(combined.df, aes(x=day)) +
  geom_line(aes(y=avg_sent, color='Sentiment')) +
  geom_line(aes(y=differential / 290, color='Differential')) + 
  scale_y_continuous(name="r/wallstreebets Average Sentiment", sec.axis = sec_axis(~.*290,name="SPY $ Differential")) +
  xlab("Date") +
  ggtitle("Average Daily WSB Sentiment Compared to SPY Daily Change") + 
  scale_color_manual("Plot Lines",values = c("Sentiment"="red2","Differential"="blue2")) +
  scale_x_date(date_breaks = "2 month",
               limits = as.Date(c('2019-02-19','2019-07-01'))) +
  theme(legend.position = c(0.12,0.85))


ggplot(combined.df, aes(x=day)) +
  geom_line(aes(y=avgsent_cumsum, color='Avg Sent Sum')) +
  geom_line(aes(y=Close / 129, color='SPY Close')) + 
  scale_y_continuous(name="r/wallstreebets Average Cumulative Sentiment", sec.axis = sec_axis(~.*129,name="SPY $ Close")) +
  xlab("Date") +
  scale_color_manual("Plot Lines",values = c("Avg Sent Sum"="red2","SPY Close"="cyan3")) + 
  ggtitle("Cumulative Average Sentiment of WSB with SPY Closing Value") +
  theme(legend.position = c(0.8,0.2))


