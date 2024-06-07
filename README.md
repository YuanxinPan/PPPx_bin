# PPPx\_bin

PPPx is a versatile multi-GNSS data processing software package. Its capabilities go beyond Precise Point Positioning (PPP).

This repository includes several executables of PPPx:
- [pppx](example/pppx/README.md): The main program of PPPx, dedicated to positioning
- [clkcomb](example/clkcomb/README.md): A program for PPP-AR products combination
- [seid](example/seid/README.md): An implemation of the [SEID](https://doi.org/10.1029/2009GL040018) method

> Note: The binaries were built with gcc 11.3.0 on Ubuntu 22.04



## Getting Started

### Prerequisites

The following libraries should be installed first to run the programs:
- [ceres solver](http://ceres-solver.org)
- [spdlog](https://github.com/gabime/spdlog)

On a Ubuntu machine, you can run the following command for installation:
```shell
sudo apt install libceres-dev libspdlog-dev
```



### Example

Several examples are provided in the `example/` directory. Please execute the correspoding `run.sh` to see how the programs work.



## Contributing

Please create an issue if you encounter any issues related to the usage of the PPPx software.



## Contact

yxpan.im@gmail.com
