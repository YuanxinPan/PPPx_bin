## Introduction

This example demonstrates the high-precision ZTD estimation with Android
smartphone GNSS data, which was published on the journal
[Atmospheric Measurement Techniques](https://doi.org/10.5194/amt-17-4303-2024).

The data collection details can be found in the paper mentioned above.
In total, three devices were used to collect 24 h GNSS data:
1. ETH2: A geodetic-grade GNSS station
2. UBLX: A u-blox receiver connected with a patch antenna
3. PIXL: A Google Pixel 4XL smartphone


## Usage

Download the GNSS data from [here](https://doi.org/10.3929/ethz-b-000676086).
Then uncompress the zip file in this folder and convert the `23d` files to `23o`
files with the tool [crx2rnx](https://terras.gsi.go.jp/ja/crx2rnx.html):

```shell
unzip dataset_2023-05-18.zip
cd dataset_2023-05-18/
for f in *.23d; do crx2rnx $f; done

./run.sh
python plot_ztd.py
```

The ZTD estimates can be found in the corresponding `pos file` (the last three columns).
```
ZTD = zhd + zwd + dzwd
```



## Citation

You can cite our [AMT paper](https://doi.org/10.5194/amt-17-4303-2024)
if you benefit from the PPPx software or the open-sourced GNSS dataset:

```
Pan, Y., Kłopotek, G., Crocetti, L., Weinacker, R., Sturn, T., See, L., ... & Soja, B. (2024).
Determination of high-precision tropospheric delays using crowdsourced smartphone GNSS data.
Atmospheric Measurement Techniques, 17(14), 4303-4316.
https://doi.org/10.5194/amt-17-4303-2024
```
