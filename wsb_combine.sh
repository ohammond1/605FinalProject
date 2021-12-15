#!/bin/bash                                                                     

head -1 wsb_chunk1.csv.out > combined_sentiment.csv
tail -n +2 -q wsb_chunk*.csv.out >> combined_sentiment.csv


