import pandas as pd
import datetime

#df_test = pd.read_csv("./wsb_comments_raw.csv",skiprows=129882, nrows=10)
filename = './wsb_comments_raw.csv'
i = 1
chunksize=1000000
with pd.read_csv(filename, chunksize=chunksize, low_memory=False,usecols=['body','created_utc']) as reader:
    for chunk in reader:
        outfile = 'wsb_chunk' + str(i) + '.csv'
        chunk.to_csv(outfile,index=False)
        i += 1
        if i % 2 == 0:
            print(i)
            print(datetime.datetime.now())


#to read in second dataset, starting with 35 to pick up where last chunks left off
file = './wallstreetbets_comments.csv'
j = 35
with pd.read_csv(file, chunksize=chunksize,usecols=['body','created_utc'],low_memory=False) as reader:
    for chunk in reader:
        outfile = 'wsb_chunk' + str(j) + '.csv'
        chunk.to_csv(outfile,index=False)
        j += 1
        if j % 2 == 0:
            print(j)
            print(datetime.datetime.now())
