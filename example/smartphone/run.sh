#!/bin/bash

[ ! -d products ] && unzip products.zip

[ -f dataset_2023-05-18/ETH21380.23o ] && echo -e "\n ETH21380.23o" && ../../bin/pppx dataset_2023-05-18/ETH21380.23o eth2.ini
[ -f dataset_2023-05-18/UBLX1380.23o ] && echo -e "\n UBLX1380.23o" && ../../bin/pppx dataset_2023-05-18/UBLX1380.23o ublx.ini
[ -f dataset_2023-05-18/PIXL1380.23o ] && echo -e "\n PIXL1380.23o" && ../../bin/pppx dataset_2023-05-18/PIXL1380.23o pixl.ini
