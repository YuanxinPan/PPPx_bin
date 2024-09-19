#!/bin/bash


[ ! -d products ] && unzip products.zip


BIN_DIR="../../bin"
DATA_DIR="./rinex"

rnx="ZIM200CHE_R_20221000000_01D_30S_MO.rnx"
ref="ZIMM00CHE_R_20221000000_01D_30S_MO.rnx"
plt="../../scripts/plot_ppppos.py"
echo "$rnx"


examples=(00_spp_if 01_spp_sf 02_ppp_ekf 03_ppp_fgo 04_ppp_brdc 05_rtk)
messages=("ionosphere-free combination" "single-frequency with GIM product" \
          "Extended Kalman Filter"      "Factor Graph Optimization" \
          "broadcast ephemeris + EKF"   "short baseline with L1 only")
args=("" "" "-s" "-s" "" "-s")

for i in {0..5}
do
    echo -e "\n==> ${examples[$i]} (${messages[$i]})"

    # $ref will only be used if sol_mode is rtk
    # The last argument is always treated as config file
    $BIN_DIR/pppx $DATA_DIR/$rnx $DATA_DIR/$ref ${examples[$i]}.ini

    $plt ${examples[$i]}/${rnx/rnx/pos} ${args[$i]}
done
