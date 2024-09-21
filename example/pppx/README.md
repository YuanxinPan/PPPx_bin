## Introduction

`pppx` is the program dedicated to positioning:
- Support four solution modes
    - SPP: Single Point Positioning
    - PPP: Precise Point Positioning
    - RTK: short baseline processing
    - TDP: Time-Differenced Positioning
- Support GPS/GLONASS/Beidou-2+3/Galileo/QZSS
- Support LSQ, EKF and FGO as solvers
- Flexible frequency selection (L1/L2/L5/...)
- High-precision yet computation efficient
- Unified input/output format



## Usage

The general way to execute `pppx` is:

```shell
pppx path-to-rnxobs [rnxobs-of-base] pppx.ini

# For example

# SPP/PPP/TDP
# Note: TDP should be used with high-frequency data (e.g., 1 Hz)
pppx rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx pppx.ini

# RTK
# ZIMM will be the base station in this way
pppx rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx rinex/ZIMM00CHE_R_20221000000_01D_30S_MO.rnx pppx.ini
```



### Input

1. Configuration file: `pppx.ini`
2. GNSS observations in RINEX format, specified by command line arguments
3. Satellite products (option: brdc or precise), specified by `pppx.ini`
    - brdc: [broadcast ephemeris](https://cddis.nasa.gov/archive/gnss/data/daily/2024/brdc/). RINEX-4 is not supported yet
    - precise: [IGS](https://cddis.nasa.gov/archive/gnss/products/) satellite orbit, clock and attitude (optional) products
4. Table files (already provided in the `table/` directory, specified by `pppx.ini`)



### Output

1. `pos file`: Receiver position, clock and ZTD estimates for every epoch
2. `log file`: Information for debugging
3. `stat file`: Postfit residuals and various estimates in the RTKLIB stat format, dedicated to visualization with [rtkplot](https://github.com/tomojitakasu/RTKLIB_bin/tree/rtklib_2.4.3)



### Processing

1. Prepare RINEX observation files and necessary products (either brdc or precise)
2. Modify the configuration file `pppx.ini`
3. Execute `pppx` with correct command line arguments



#### Configuration

Most settings inside `pppx.ini` is self-explained. Usually, users need to modify the following settings:
```ini
[session]: date
[constellation]: system
[estimation]: sol_mode, pos_mode, solver
[product]: src, nav, sp3, clk
```

Although most settings are shared by different sol\_mode (i.e., spp/ppp/rtk/tdp), some settings are sol\_mode specific:
```ini
[model]: trop, iono
; not effective for rtk and tdp
; Tropospheric and ionospheric delays are ignored for short baseline or short time interval

[estimation]: solver
; spp/tdp: only lsq and fgo are supported
; ppp: only kalman and fgo are supported
; rtk: only kalman is supported

[estimation]: slip_det
; only effective for ppp
; rtk and tdp always use LLI and GF to detect cycle slips

[estimation]: pos_pri, clk_pri, isb_pri, ztd_pri
; only effective for ppp
```



### Visualization

#### With python

```shell
# plot position estimates only
../../scripts/plot_ppppos.py pos_file

# plot position, receiver clock and ZTD estimates
.././scripts/plot_ppppos.py pos_file -a

# -i interactive mode
# -s fixed scale of y-axis, otherwise automatically scaled
```

#### With RTKLIB

Simply drag the `stat` file to the GUI of [rtkplot](https://github.com/tomojitakasu/RTKLIB_bin/tree/rtklib_2.4.3)



## Example

An exmaple is provided for PPP processing:

```shell
cd example/pppx/
./run.sh   # processing & plotting
```

**FGO-based kinematic PPP for ZIM2 (GPS + Galileo, 2022-100)**

<img src="03_ppp_fgo/ZIM200CHE_R_20221000000_01D_30S_MO.png" width="500">

