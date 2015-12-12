#!/usr/bin/env python

from scipy.stats import binom
import numpy as np
import matplotlib.pylab as pl

for p in [0.25, 0.9]:
    pl.figure()
    probabilities = binom.pmf(np.arange(11), 10, p)
    pl.bar(np.arange(11), probabilities)
    pl.xticks(np.arange(11) + 0.4, np.arange(11))
    pl.title(r'$\theta = %.3f$' % p)
    pl.savefig('binomDistPlot_%s.png' % p)
pl.show()
