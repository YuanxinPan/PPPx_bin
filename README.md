# PPPx_bin

Executables for the PPPx software package

> This test version was built for Linux users only

# PPPx

A software package for multi-GNSS Precise Point Positioning

- Modular design
- Support GPS/GLONASS/Beidou/Galileo/QZSS
- Flexible frequency selection (L1/L2/L5/...)
- High-precision yet computation efficient
- Dual-frequency Ionosphere-free combination
- Ambiguity Resolution not implemented yet

# Usage

1. Download precise satellite products: sp3+clk+erp

2. Modify the configuration file `ppp.ini`
    - session time
    - GNSS constellations
    - model & solver settings
    - path to products
    - path to tables

3. Run the command

```
./bin/ppp path-to-rinexobs ppp.ini -v
```

4. Visualization

- Option 1: python script

```
./bin/plot_ppppos.py .pos_file -s
```

- Option 2: rtkplot (RTKLIB)

Simply drag the generated .stat file to the GUI of rtkplot

# Example

```
cd example/
./test.sh
```

![Kinematic PPP using GEC data for ZIM2 on 2022-100 ](example/ZIM200CHE_R_20221000000_01D_30S_MO.png | width=800)
**Kinematic PPP using GEC data for ZIM2 on 2022-100**

# Note

- The binary was built with gcc 11.3.0 on Ubuntu 22.04
- Initial position should be provided in the RINEX-OBS header
- ERP file should contain 3 days records
- Please create an issue if you encounter any issues related to the software

# Contact

yxpan.im@gmail.com
