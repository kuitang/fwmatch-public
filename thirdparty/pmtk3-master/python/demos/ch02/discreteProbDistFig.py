#!/usr/bin/env python

import numpy as np
import matplotlib.pylab as pl

pl.bar(np.arange(4) + 0.5, [0.25] * 4)
pl.axis([0, 5, 0, 1])
pl.xticks(np.arange(4) + 0.9, np.arange(4) + 1)
pl.savefig('discreteProbDistFig_a.png')

pl.figure()
pl.bar(0.5, 1)
pl.axis([0, 5, 0, 1])
pl.xticks(np.arange(4) + 0.9, np.arange(4) + 1)
pl.savefig('discreteProbDistFig_b.png')
pl.show()
