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
