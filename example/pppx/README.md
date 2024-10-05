## Introduction

This example demonstrates several common use cases of the `pppx` program:
0. SPP using broadcast ephemeris with ionosphere-free (IF) combination (solver: LSQ)
1. SPP using broadcast ephemeris and GIM with single-frequency (SF) observations (solver: LSQ)
2. IF-PPP using precise products (solver: EKF)
3. IF-PPP using precise products (solver: FGO)
4. IF-PPP using broadcast ephemeris (solver: EKF)
5. PPP-AR using precise products (solver: EKF)
6. Short baseline processing using broadcast ephemeris (solver: EKF)

The visualizations are available in their respective solution folders.


## Usage

Run the following command:

```shell
./run.sh
```

Then, the result files (`.pos`, `.log`, and `.stat`) can be found in their
respective solution folders.
