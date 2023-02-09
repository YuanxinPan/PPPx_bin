#!/usr/bin/env python3

import sys
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FormatStrFormatter

if not len(sys.argv) in (2, 3, 4):
    print("usage: %s pos [-s] [-i]"%(sys.argv[0]))
    sys.exit(1)

squeeze = False      # squeeze y-axis
interactive = False  # interactive show
for argv in sys.argv:
    if argv == '-s':
        squeeze = True
    elif argv == '-i':
        interactive = True

# Load data
data = np.loadtxt(sys.argv[1], usecols=(1,2,6,7,8), skiprows=1)
t = data[:, 0]/3600                     # convert time to hours
data = np.roll(data[:, 1:], -1, axis=1) # shift ENU/nsat columns

mean = np.zeros(3)
std = np.zeros(3)
for i in range(3):
    data[:, i] *= 100  # m -> cm
    mean[i] = data[120:, i].mean()
    std[i]  = data[120:, i].std()
    data[:, i] -= mean[i]

print(f"{std[0]:8.2f} {std[1]:8.2f} {std[2]:8.2f}")

if sys.platform in [ 'linux', 'linux2' ]:
    plt.rc('font', family='Liberation Sans')
elif sys.platform in [ 'win32', 'darwin' ]:
    plt.rc('font', family='Arial')
#  The default figure size is (6.4, 4.8) inches. A larger
# figure size will allow for longer texts, more axes or more
# ticklabels to be shown. Thus, largers figsize means larger paper.
#  The default dpi is 100. Larger dpi behaves like 'Zoom In'.
fig, axes = plt.subplots(4, 1, sharex=True, dpi=144, figsize=(6.4, 6.4))

# Plot
markers= [ 'r.', 'g.', 'b.', 'k.' ]
labels = [ "East (cm)", "North (cm)", "Up (cm)", "Nsat"  ]
ylimts = [ [-10, 10], [-10, 10], [-20, 20] ]
for i in range(4):
    axes[i].plot(t, data[:, i], 'grey', linewidth=.5)
    axes[i].plot(t, data[:, i], markers[i], markersize=1)
    axes[i].set_ylabel(labels[i])
    if i != 3 and squeeze:
        axes[i].set_ylim(ylimts[i])

for i in range(3):
    axes[i].text(0.96, 0.80, f"{std[i]:5.2f} cm", fontsize=12,
                 horizontalalignment='right', verticalalignment='center', transform=axes[i].transAxes)
axes[3].set_xlabel('Time (hours)')
axes[3].set_xlim([0, 24])

i = 0
# Partition Configuration
for a in axes:
    # Frame Width
    fwidth = 1.5
    a.spines['bottom'].set_linewidth(fwidth)
    a.spines['left'].set_linewidth(fwidth)
    a.spines['top'].set_linewidth(fwidth)
    a.spines['right'].set_linewidth(fwidth)
    # Tick
    a.tick_params(axis='both', which='both', direction='in', right=True, top=True)
    a.tick_params(axis='both', which='major', length=4)
    a.tick_params(axis='both', which='minor', length=2)
    # Notation (tick label)
    a.tick_params(axis='both', labelsize=12)
    a.tick_params(axis='x', labelrotation=0.0)
    a.xaxis.set_major_locator(MultipleLocator(2))
    a.xaxis.set_minor_locator(MultipleLocator(0.5))
    a.xaxis.set_major_formatter(FormatStrFormatter('%d'))
    if squeeze:
        a.yaxis.set_major_locator(MultipleLocator(10))
        a.yaxis.set_minor_locator(MultipleLocator(2))
        a.yaxis.set_major_formatter(FormatStrFormatter('%d'))
    if i == 3:
        a.yaxis.set_major_locator(MultipleLocator(2))
        a.yaxis.set_minor_locator(MultipleLocator(1))
        a.yaxis.set_major_formatter(FormatStrFormatter('%d'))
    # Label
    a.xaxis.label.set_size(12)
    a.yaxis.label.set_size(12)
    i += 1

# Global Configuration
mpl.rcParams['lines.linewidth'] = 0.5
mpl.rcParams['lines.markersize'] = 0.1
fig.subplots_adjust(hspace=0.12)
fig.align_labels()

# Output
plt.savefig(sys.argv[1][:-3]+'png', bbox_inches='tight', pad_inches=None)
if interactive:
    plt.show()
