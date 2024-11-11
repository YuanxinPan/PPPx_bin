import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FormatStrFormatter

def read_data(path):
    df = pd.read_csv(path, usecols=(1,2,3,4,5,9,10,11,12), delimiter='\s+')
    df['hour'] = df['sod']/3600
    df['ztd'] = df['zhd'] + df['zwd'] + df['dzwd']
    return df

def format_axis(a, major_tick=None, minor_tick=None):
    fwidth = 1.5
    a.spines['bottom'].set_linewidth(fwidth)
    a.spines['left'].set_linewidth(fwidth)
    a.spines['top'].set_linewidth(fwidth)
    a.spines['right'].set_linewidth(fwidth)

    a.tick_params(axis='both', which='both', direction='in', right=True, top=True)
    a.tick_params(axis='both', which='major', length=4)
    a.tick_params(axis='both', which='minor', length=2)

    a.xaxis.set_major_locator(MultipleLocator(4))
    a.xaxis.set_minor_locator(MultipleLocator(0.5))
    a.xaxis.set_major_formatter(FormatStrFormatter('%d'))
    if major_tick is not None:
        a.yaxis.set_major_locator(MultipleLocator(major_tick))
    if minor_tick is not None:
        a.yaxis.set_minor_locator(MultipleLocator(minor_tick))


eth2 = read_data("ETH21380.pos")
ublx = read_data("UBLX1380.pos")
pixl = read_data("PIXL1380.pos")

fig, axes = plt.subplots(1, 1, sharex=True, dpi=200, figsize=(6.4, 3.4))

axes.plot(eth2['hour'], eth2['ztd']*1E3, label='ETH2', color='k')
axes.plot(ublx['hour'], ublx['ztd']*1E3, label='UBLX', color='tab:blue')
axes.plot(pixl['hour'], pixl['ztd']*1E3, label='PIXL', color='tab:red')

axes.legend()
axes.set_xlim([0, 24])
axes.set_ylim([2256, 2304])
axes.set_xlabel("Time (hour)")
axes.set_ylabel("ZTD (mm)")
format_axis(axes)

fig.savefig('output.png', bbox_inches='tight', pad_inches=None)
