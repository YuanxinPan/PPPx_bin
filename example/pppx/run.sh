#!/bin/bash

DATA_DIR="./rinex"
SOL_DIR="user_output"



[ ! -d products ] && unzip products.zip



rnx="ZIM200CHE_R_20221000000_01D_30S_MO.rnx"
echo "$rnx"


echo -e "\n==> 00_spp (ionosphere-free combination)"
../../bin/pppx_static rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx 00_spp.ini
../../scripts/plot_ppppos.py 00_spp/${rnx/rnx/pos}

echo -e "\n==> 01_spp_ionex (GIM product)"
../../bin/pppx_static rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx 01_spp_ionex.ini
../../scripts/plot_ppppos.py 01_spp_ionex/${rnx/rnx/pos}

echo -e "\n==> 02_ppp (precise satellite products)"
../../bin/pppx_static rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx 02_ppp.ini
../../scripts/plot_ppppos.py 02_ppp/${rnx/rnx/pos} -s

echo -e "\n==> 03_ppp_brdc (broadcast ephemeris)"
../../bin/pppx_static rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx 03_ppp_brdc.ini
../../scripts/plot_ppppos.py 03_ppp_brdc/${rnx/rnx/pos}

echo -e "\n==> 04_rtk"
../../bin/pppx_static rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx rinex/ZIMM00CHE_R_20221000000_01D_30S_MO.rnx 04_rtk.ini
../../scripts/plot_ppppos.py 04_rtk/${rnx/rnx/pos} -s

echo -e "\n==> 05_ppp_fgo (Factor Graph Optimization)"
../../bin/pppx rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx rinex/ZIMM00CHE_R_20221000000_01D_30S_MO.rnx 05_ppp_fgo.ini
../../scripts/plot_ppppos.py 05_ppp_fgo/${rnx/rnx/pos} -s
