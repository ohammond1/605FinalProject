#!/bin/bash

# untar your R installation
tar -xzf R402.tar.gz
tar -xzf packages_dplyr_lub_sentr.tar.gz

# make sure the script will use your R installation, 
# and the working directory as its home location
export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
export R_LIBS=$PWD/packages

#fname=${2%.*}

#tar -xf "${fname}.tgz"
wget https://github.com/ohammond1/605FinalProject/raw/main/data_tar/${1}

tar -xf $1
fname=${1%.tar.gz}


Rscript SentimentCode.R "${fname}.csv"

rm -rf $1
rm -rf "${fname}.csv"
