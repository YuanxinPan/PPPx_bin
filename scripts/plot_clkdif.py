#!/usr/bin/env python3
import sys
import math
import warnings
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FormatStrFormatter

if len(sys.argv) != 3:
    print('usage plot_clkdif.py temp_dir prn')
    sys.exit(1)

temp_dir = sys.argv[1]
prn      = sys.argv[2]

with open(temp_dir + '/ac_list') as f:
    ACs = f.read().splitlines()

fig, ax = plt.subplots(1, 1, dpi=144, figsize=(6.4, 4.8))

for ac in ACs:
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        filename = temp_dir + '/dif_' + ac + '_' + prn
        clkdif = np.loadtxt(filename, usecols=(3,4)) # epo clkdif
        filename = temp_dir + '/del_' + ac + '_' + prn
        clkdel = np.loadtxt(filename, usecols=(4,), dtype='int') # epo of del

    if len(clkdif) == 0:
        continue
    ax.plot(clkdif[:,0], clkdif[:,1], marker='.', label=ac.upper())


    if clkdel.size != 0:
        ax.plot(clkdel, clkdif[clkdel,1], 'x', color='k', markersize=4)

ax.text(100, -0.25, prn, fontsize=14)
ax.set_xlim([-120, 3000])
ax.set_ylim([-0.3, 0.3])
ax.set_xlabel('Epoch')
ax.set_ylabel("Clock difference w.r.t. ref AC (ns)")
plt.legend()

# frame width
bwidth=1.5
ax.spines['bottom'].set_linewidth(bwidth)
ax.spines['left'].set_linewidth(bwidth)
ax.spines['top'].set_linewidth(bwidth)
ax.spines['right'].set_linewidth(bwidth)

## format the ticks
ax.tick_params(axis='both', which='both',direction='in', right=True, top=True)
ax.tick_params(axis='both', which='major', length=5)  # Tick length
ax.tick_params(axis='both', which='minor', length=2)  # Tick length
ax.tick_params(axis='both', labelsize=10)
ax.tick_params(axis='both', pad=4)
ax.xaxis.label.set_size(12)
ax.yaxis.label.set_size(12)

plt.savefig(prn + '.png', pad_inches=0.01, bbox_inches='tight')
# plt.show()
