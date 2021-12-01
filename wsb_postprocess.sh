#!/bin/bash

cat *.csv > combined_sentiment.csv

Rscript wsb_postprocess.R
