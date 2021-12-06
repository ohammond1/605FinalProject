#!/bin/bash

head -1 output/data_out/wsb_chunk1.csv.out > combined_sentiment.csv
tail -n +2 -q output/data_out/wsb_chunk*.csv.out >> combined_sentiment.csv

