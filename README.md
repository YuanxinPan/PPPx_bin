# PPPx_bin

Executables for the PPPx software package

> This test version was built for Linux users only


# Table of Contents
- [Introduction](#introduction)
- [Module: ppp](#module_ppp)
    - [Usage](#usage_ppp)
    - [Example](#example_ppp)
- [Module: clkcomb](#module_clkcomb)
    - [Usage](#usage_clkcomb)
    - [Example](#example_clkcomb)
- [Module: seid](#module_seid)
    - [Usage](#usage_seid)
- [Note](#note)
- [Contact](#contact)


## Introduction <a name="introduction"></a>

PPPx is a versatile multi-GNSS data processing software package. Its capabilities
go beyond Precise Point Positioning (PPP).


## Module: ppp <a name="module_ppp"></a>

- Support GPS/GLONASS/Beidou-2+3/Galileo/QZSS
- Flexible frequency selection (L1/L2/L5/...)
- High-precision yet computation efficient
- Dual-frequency Ionosphere-free combination
- Ambiguity Resolution not implemented yet

### Usage <a name="usage_ppp"></a>

1. Download precise satellite products: sp3+clk+erp+[obx]

> Nominal satellite attitude will be used if there is no `obx` product

> `erp` product should contain at least 3 days' records (for interpolation)

2. Modify the configuration file `ppp.ini`
    - session time
    - GNSS constellations
    - model & solver settings
    - path to products
    - path to tables

3. Run the command

```shell
./bin/ppp path-to-rinexobs ppp.ini -v
```

> Note: initial position should be provided in the RINEX-OBS header

> You can exclude problematic satellites in `ppp.ini` accroding to postfit residuals (visualization with rtkplot)

4. Visualization

- Option 1: python script

```shell
./scripts/plot_ppppos.py .pos_file -s
```

- Option 2: rtkplot (RTKLIB)

Simply drag the generated .stat file to the GUI of rtkplot

### Example <a name="example_ppp"></a>

```shell
cd example/ppp/
./test.sh   # processing & plotting
```

**Kinematic PPP using GEC data for ZIM2 on 2022-100**

<img src="example/ppp/ZIM200CHE_R_20221000000_01D_30S_MO.png" width="600">

## Module: clkcomb <a name="module_clkcomb"></a>

- Support multi-GNSS clock products combination & comparison
- Support phase bias products combination for PPP-AR

### Usage <a name="usage_clkcomb"></a>

1. Download IGS products for each AC: sp3+clk+[bia]+[obx]

> Two days' sp3 products needed (day & day+1)

2. Modify the configuration file `comb.ini`
    - session time
    - GNSS constellations
    - path to AC products
    - ...

3. Run the command

```shell
./bin/clkcomb comb.ini
```

4. Visualization

```shell
./scripts/plot_clkdif.sh dif_file log_file
```

### Example <a name="example_clkcomb"></a>

```shell
cd example/clkcomb/
./test.sh   # combination & plotting
```

> More details about clock combination can be found [here](https://doi.org/10.27379/d.cnki.gwhdu.2021.000240)

**Clock comparison for G21 on 2022-001**

<img src="example/clkcomb/G21.png" width="600">


## Module: seid <a name="module_seid"></a>

`seid` is an implementation of the
[Satellite-specific Epoch-differenced Ionospheric Delay](https://doi.org/10.1029/2009GL040018)
method.  It can convert the single-frequency GNSS data to dual-frequency data
using the observations from nearby geodetic GNSS stations, which is useful for
single-frequency GNSS data processing.


### Usage <a name="usage_seid"></a>

```shell
seid path-to-rnxobs seid.ini
```


## Note <a name="note"></a>

- The binary was built with gcc 11.3.0 on Ubuntu 22.04
- Please create an issue if you encounter any issues related to the software


## Contact <a name="contact"></a>

yxpan.im@gmail.com
