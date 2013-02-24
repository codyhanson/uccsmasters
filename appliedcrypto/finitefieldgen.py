#! /usr/bin/env python

from BitVector import BitVector as bv
from numpy import poly1d as P

n = 4
m = bv(bitlist = [1,0,0,1,1])

print 'computing GF(2^n)'
print 'n = {0}'.format(n)
print 'modulus m = '
print P(list(m))

for i in range(0,2**n):
    a1 = bv(bitlist=[0,0,1,0])
    a = a1
    if (i == 0):
        #0 case.
        a = bv(bitlist=[0,0,0,0])
    else:
        for j in range(1,i):
            a = a.gf_multiply_modular(a1,m,n) 
    
    print '============================================'
    print 'g^{0}'.format(i)
    print 'Binary: {0}'.format(a)
    print 'Hex: {0}'.format(a.getHexStringFromBitVector())
    print 'Polynomial:'
    print P(list(a))
