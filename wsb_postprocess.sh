#!/bin/bash                                                                     
# untar your R installation
tar -xzf R402.tar.gz
tar -xzf packages_dplyr_lub_sentr.tar.gz

# make sure the script will use your R installation, 
# and the working directory as its home location
export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
export R_LIBS=$PWD/packages

wget https://github.com/ohammond1/605FinalProject/raw/main/HistoricalPrices.csv

Rscript wsb_post.R
