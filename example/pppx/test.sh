#!/bin/bash

DATA_DIR="../ppp/data"

for f in ${DATA_DIR}/*.rnx
do
    rnx=`basename $f`

    echo "$rnx"
    ../../bin/pppx ${DATA_DIR}/$rnx pppx.ini || continue
done
