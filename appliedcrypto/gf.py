#! /usr/bin/env python

#computes tables that demonstrate arithmetic in Galois fields.

import sys

#borrowed from euclidextended.py
#for finding multiplicative inverses
def euclid(a, b,xminus1,xminus2,yminus1,yminus2):
    if (a == 0 and b == 0):
        return (0,0,0)
    elif (b == 0):
        return (a,xminus2,yminus2)
    else:
        q = a/b
        x = xminus2 - q*xminus1
        y = yminus2 - q*yminus1
        return euclid(b, a % b,x,xminus1,y,yminus1)


p = int(sys.argv[1])

#build top line
topline = "{0:3}||".format(" ")
sep = "-" * (5 + 6*p)
for i in range(p):
   topline = topline + "{0:5}|".format(i) 


print "Addition Table"
print topline
for i in range(p):
    line = "{0:3}||".format(i)
    for j in range(p):
      line = line + "{0:5}|".format(((i + j) % p))
    print sep
    print line

print "Multiplication Table"
print topline
for i in range(p):
    line = "{0:3}||".format(i)
    for j in range(p):
      line = line + "{0:5}|".format(((i * j) % p))
    print sep
    print line


print "Inverse Table"
print "{0:3}||{1:>10}|{2:>10}|".format(" ","AddInv","MultInv")
for i in range(p):
    line = "{0:3}||".format(i)
    addinv = p - i
    if (i == 0):
        addinv = 0
    line = line + "{0:10}|".format(addinv)
    (gcd,multinv,other) = euclid(i,p,0,1,1,0)
    if (multinv < 0):
        multinv = multinv + p
    if (multinv == 0):
        multinv = "none"
    line = line + "{0:>10}|".format(multinv)
    print line


