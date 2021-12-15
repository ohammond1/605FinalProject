# r/wallstreetbets Sentiment Analysis
605 Final Project investigating the sentiment of r/WallStreetBets subbreddit and comparing that to the daily change in the S&P 500 index

git clone https://github.com/ohammond1/605FinalProject.git

### Running CHTC Code
All of the code to run code on the chtc code is included in the chtc_code folder. It can be created into a tar, uploaded to chtc, and run. To run the parallel jobs use
```
condor_dagman wsb.dag
```
The function will first download the individual data tar.gz files from the github repository and run 34 jobs analyzing the sentiment of each job. Each of these jobs will create a single output file that is saved back to the main folder.

These individual ouptut files have a list of the distinct dates in the original tar.gz, the average sentiment, and the number of comments for each day.

Next, wsb_combine.sh runs to merge these individual files into a single combined file by concatenating them all together.

agg_wsb.sub is then called to run a single job to run the post processing script and R code. This take the combined_sentiment.csv file, aggregates it and claculates the correlation coefficient for a few different comparisons between SPY and r/wallstreetbets daily average sentiment. These values are output into the ouput file of the final job.
