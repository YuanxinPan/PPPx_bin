#!/bin/bash

DATA_DIR="./rinex"
SOL_DIR="user_output"

[ ! -d products ] && unzip products.zip

for f in ${DATA_DIR}/ZIM2*.rnx
do
    rnx=`basename $f`

    echo "$rnx"
    ../../bin/pppx ${DATA_DIR}/$rnx pppx.ini || continue

    echo -e "\nplotting ${SOL_DIR}/${rnx/rnx/png}"
    ../../scripts/plot_ppppos.py ${SOL_DIR}/${rnx/rnx/pos} -s
done
