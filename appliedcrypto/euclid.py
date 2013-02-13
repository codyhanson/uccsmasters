#! /usr/bin/env python
import sys

#Euclidean algorithm for greatest common divisor computation
def euclid(a, b):
    if (a == 0 and b == 0):
        return 0
    elif (b == 0):
        return a
    else:
        return euclid(b, a % b)

#main

if (len(sys.argv) < 3):
    print "Usage: euclid [int a] [int b]"
    sys.exit(-1)

a = int(sys.argv[1])
b = int(sys.argv[2])

print euclid(a,b)
