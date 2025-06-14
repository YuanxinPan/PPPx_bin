#!/bin/bash


[ ! -d products ] && unzip products.zip


DATA_DIR="./rinex"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    pppx="../../bin/linux/pppx"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    pppx="../../bin/macos/pppx"
else
    pppx="../../bin/windows/pppx"
fi


rnx="ZIM200CHE_R_20221000000_01D_30S_MO.rnx"
ref="ZIMM00CHE_R_20221000000_01D_30S_MO.rnx"
plt="../../scripts/plot_ppppos.py"
echo "$rnx"


examples=(00_spp_if 01_spp_sf 02_ppp_ekf 03_ppp_fgo 04_ppp_brdc 05_pppar_ekf 06_rtk)
messages=("ionosphere-free combination" "single-frequency with GIM product" \
          "Extended Kalman Filter"      "Factor Graph Optimization" \
          "broadcast ephemeris + EKF"   "PPP-AR + EKF" \
          "short baseline with L1 only")
args=("" "" "-s" "-s" "" "-s" "-s")

for i in {0..6}
do
    echo -e "\n==> ${examples[$i]} (${messages[$i]})"

    # $ref will only be used if sol_mode is rtk
    # The last argument is always treated as config file
    $pppx -c ${examples[$i]}.ini $DATA_DIR/$rnx $DATA_DIR/$ref || continue

    $plt ${examples[$i]}/${rnx/rnx/pos} ${args[$i]}
done


echo -e "07_tdp (LSQ + precise products)"
$pppx -c 07_tdp.ini $DATA_DIR/ALGO00CAN_R_20221000000_15M_01S_MO.rnx && $plt 07_tdp/ALGO00CAN_R_20221000000_15M_01S_MO.pos -s
