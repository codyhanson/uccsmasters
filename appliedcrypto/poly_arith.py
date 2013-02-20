#! /usr/bin/env python

from numpy.polynomial import Polynomial as P


#polynomial coefficients
pm = P([2,0,1,1])
m = len(pm)

pn = P([1,-1,1])
n =  len(pn)

print pm
print pn

print pm + pn
print pm - pn
print pm * pn
print pm / pn
print pm // pn
print pm % pn
