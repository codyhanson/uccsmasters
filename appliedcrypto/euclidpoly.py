#! /usr/bin/env python
import sys
import numpy as np
from numpy.polynomial import Polynomial as P
from prettypolyprint import prettyprint

#Euclidean algorithm for greatest common divisor computation
def euclid(a, b):
    #if (a == P([0]) and b == P([0])):
    #    return P([0])
    if (b == P([0])):
        return a
    else:
        return euclid(b, a % b)


if (len(sys.argv) < 3):
    print "Usage: euclid [int a] [int b]"
    sys.exit(-1)

a = []
b = []
for num in sys.argv[1].split(','):
    a.append(int(num))

for num in sys.argv[2].split(','):
    b.append(int(num))

#turn into polynomials
a.reverse()
b.reverse()
a = P(a)
b = P(b)

prettyprint(a)
prettyprint(b)
prettyprint(a * b)
prettyprint(a / b)
prettyprint(a // b)
prettyprint(a % b)

print "GCD:"
prettyprint(euclid(a,b))
