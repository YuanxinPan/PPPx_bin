#!/bin/bash

for f in ./data/*.rnx
do
    rnx=`basename $f`

    echo "$rnx"
    ../bin/ppp ./data/$rnx ppp.ini -v || continue

    echo -e "\nplotting ${rnx/rnx/pos}..."
    ../bin/plot_ppppos.py ${rnx/rnx/pos} -s
done
