## Introduction

This example demonstrates several common use cases of the `pppx` program:
1. SPP using broadcast ephemeris with ionosphere-free (IF) combination (solver: LSQ)
2. SPP using broadcast ephemeris and GIM with single-frequency (SF) observations (solver: LSQ)
3. IF-PPP using precise products (solver: EKF)
4. IF-PPP using precise products (solver: FGO)
5. IF-PPP using broadcast ephemeris (solver: EKF)
6. PPP-AR using precise products (solver: EKF)
7. Short baseline processing using broadcast ephemeris (solver: EKF)

The visualizations are available in their respective solution folders.


## Usage

Run the following command:

```shell
./run.sh
```

Then, the result files (`.pos`, `.log`, and `.stat`) can be found in their
respective solution folders.
