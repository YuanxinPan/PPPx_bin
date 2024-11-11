# PPPx\_bin

PPPx is a versatile multi-GNSS data processing software package. Its capabilities
go beyond Precise Point Positioning (PPP).

The main program, `pppx`, focuses on positioning and supports the following features:
- Solution modes:
    - SPP: Single Point Positioning
    - PPP: Precise Point Positioning
    - RTK: short baseline processing
    - TDP: Time-Differenced Positioning
- GNSS systems: GPS, GLONASS, Galileo, Beidou-2/3, QZSS
- Solvers: LSQ, EKF and FGO
- PPP-AR with OSB products (.BIA)
- Flexible frequency selection: L1/L2/L5/E1/E5a/...
- High precision and efficiency: Capable of processing 2880 epochs within 2 seconds
- Unified input/output format

Other programs in the PPPx software package include:
- [clkcomb](https://github.com/YuanxinPan/clkcomb): A program for combining PPP-AR products
- [seid](example/seid/README.md): An implemation of the [SEID](https://doi.org/10.1029/2009GL040018) method


## Installation

### Linux

`pppx` is recommendeded for use on Ubuntu, as the binary was built with gcc 11
on Ubuntu 22.04. However, it should work on most modern Linux systems with gcc 11 available.

The executable `bin/pppx` is dynamically linked against the [ceres solver](http://ceres-solver.org)
library (version >= 2.0.0), so the library `libceres-dev` must be
installed first. The installation on Linux can be done with the following commands:

```shell
sudo apt install libceres-dev
git clone git@github.com:YuanxinPan/PPPx_bin.git

mkdir -p ${HOME}/.local/bin
cp PPPx_bin/bin/pppx ${HOME}/.local/bin/
echo "export PATH=\${HOME}/.local/bin:\$PATH" >> ${ HOME}/.bashrc
# Restart your terminal afterward
```

If you don't have the sudo privilege and cannot install `libceres-dev`, you can
use the static build `bin/pppx_static`, though this version does not support FGO.

> NOTE: Currently, `pppx` appears to work only on Ubuntu 22.04 or newer, as the `libceres-dev` package in Ubuntu 20.04 and earlier is of version 1.x.x, which is incompatible.


### Windows

The easiest way to run `pppx` on Windows is via the Windows Subsystem for Linux (WSL).


## Usage

The general steps to process GNSS data with `pppx` are:
1. Prepare RINEX observation files and necessary products (either broadcast ephemeris or precise products)
2. Modify the configuration file `pppx.ini`
3. Execute `pppx` with appropriate command-line arguments:

```shell
pppx path-to-rnxo [rnxo-of-base] pppx.ini

# Example usage:

# For SPP/PPP/TDP  (Note: TDP is suitable for high-frequency data, e.g., 1 Hz)
pppx rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx pppx.ini

# For RTK (ZIMM is the base station in this example)
pppx rinex/ZIM200CHE_R_20221000000_01D_30S_MO.rnx rinex/ZIMM00CHE_R_20221000000_01D_30S_MO.rnx pppx.ini
```


### Input

1. Configuration file: [pppx.ini](pppx.ini)
2. GNSS observations: RINEX format
3. Satellite products: Broadcast ephemeris or precise products, specified in `pppx.ini`
4. Table files: Provided in the [table](table/) directory, specified in `pppx.ini`


### Output

1. `pos file`: Receiver position, clock, and ZTD estimates for each epoch
2. `log file`: Debugging information
3. `stat file`: Postfit residuals and various estimates in the RTKLIB stat format, for visualization with [RTKLIB](https://github.com/tomojitakasu/RTKLIB_bin/tree/rtklib_2.4.3)


### Visualization

#### With python

```shell
# To plot position estimates only
python scripts/plot_ppppos.py pos_file

# To plot position, receiver clock and ZTD estimates
python scripts/plot_ppppos.py pos_file -a

# -a  Plot receiver position, clock, and ZTD estimates
# -i  Interactive mode
# -s  Fixed scale for the y-axis; otherwise, scale is set automatically
```

#### With RTKLIB

For enhanced interactive viewing and visualization of postfit residuals:

1. Open the `rtkplot.exe` application
2. Navigate to "File" > "Open Solution-1" and select the generated stat file
3. Interactively view various plots


## Example

To help you get started, several examples are available in the
[example/pppx](example/pppx) folder. Additionally, an example demonstrating
`pppx` processing of GNSS data collected by Android smartphones is provided in
the [example/smartphone](example/smartphone) folder. Please execute the
correspoding `run.sh` script to see how `pppx` works:

```shell
cd example/pppx/
./run.sh   # processing & plotting
```

For instance, the following is a visualization of a kinematic PPP solution for
the ZIM2 station, using FGO and GPS+Galileo observations:

<img src="example/pppx/03_ppp_fgo/ZIM200CHE_R_20221000000_01D_30S_MO.png" width="500">


## Contributing

if you have suggestions or encounter issues related to the usage of the PPPx
software, please create an [issue](https://github.com/YuanxinPan/PPPx_bin/issues/new).


## Author

- **Yuanxin Pan** - [YuanxinPan](https://github.com/YuanxinPan)


## License

This project is licensed under the GPLv3 License - see the [LICENSE](LICENSE)
file for details.
