# PPPx\_bin

PPPx is a versatile multi-GNSS data processing software package. Its capabilities
go beyond Precise Point Positioning (PPP).

This repository includes several executables of PPPx and corresponding examples:
- [pppx](example/pppx/README.md): The main program of PPPx, dedicated to positioning
- [clkcomb](https://github.com/YuanxinPan/clkcomb): A program for PPP-AR products combination
- [seid](example/seid/README.md): An implemation of the [SEID](https://doi.org/10.1029/2009GL040018) method

> Note: The binaries were built with gcc 11.3.0 on Ubuntu 22.04



## Getting Started

### Prerequisites

The following library should be installed first to run `pppx`:
- [ceres solver](http://ceres-solver.org)

On an Ubuntu machine, you can run the following command for the installation:
```shell
sudo apt install libceres-dev
```

Other binaries, including `seid` and `pppx_static`, were built statically.
Note that `pppx_static` does not support Factor Graph Optimization (FGO) as a solver.



### Example

Several examples are provided in the [example](example/) directory. Please execute the
correspoding `run.sh` to see how the programs work.

For example, here is a PPP kinematic positioning solution for the station ZIM2
based on FGO using GPS and Galileo observations:

<img src="example/pppx/03_ppp_fgo/ZIM200CHE_R_20221000000_01D_30S_MO.png" width="500">



## Contributing

Please create an issue if you encounter any issues related to the usage of the PPPx software.



## Contact

yxpan.im@gmail.com
