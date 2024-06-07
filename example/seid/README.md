## Introduction

`seid` is an implementation of the
[Satellite-specific Epoch-differenced Ionospheric Delay](https://doi.org/10.1029/2009GL040018)
method.  It can convert the single-frequency GNSS data to dual-frequency data
using the observations from nearby geodetic GNSS stations, which is useful for
single-frequency GNSS data processing.



## Usage

```shell
seid path-to-rnxobs seid.ini
```

