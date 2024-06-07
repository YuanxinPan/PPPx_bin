#!/bin/bash

[ ! -d products ] && unzip products.zip

../../bin/clkcomb comb.ini

echo -e "\nplotting..."
../../scripts/plot_clkdif.sh 2020-001.dif 2020-001.log

mkdir -p user_output/
mv *.png 2020-001.* cmb20863.* user_output/
