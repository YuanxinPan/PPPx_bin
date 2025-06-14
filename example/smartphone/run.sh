#!/bin/bash

[ ! -d products ] && unzip products.zip


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    pppx="../../bin/linux/pppx"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    pppx="../../bin/macos/pppx"
else
    pppx="../../bin/windows/pppx"
fi


[ -f dataset_2023-05-18/ETH21380.23o ] && echo -e "\n ETH21380.23o" && $pppx dataset_2023-05-18/ETH21380.23o -c eth2.ini
[ -f dataset_2023-05-18/UBLX1380.23o ] && echo -e "\n UBLX1380.23o" && $pppx dataset_2023-05-18/UBLX1380.23o -c ublx.ini
[ -f dataset_2023-05-18/PIXL1380.23o ] && echo -e "\n PIXL1380.23o" && $pppx dataset_2023-05-18/PIXL1380.23o -c pixl.ini
