#! /usr/bin/env python
import sys

#Euclidean algorithm for greatest common divisor computation
#enhanced to find values x and y such that ax + by = d = gcd(a,b)
def euclid(a, b,xminus1=0,xminus2=1,yminus1=1,yminus2=0):
    if (a == 0 and b == 0):
        return (0,0,0)
    elif (b == 0):
        return (a,xminus2,yminus2)
    else:
        q = a/b
        x = xminus2 - q*xminus1
        y = yminus2 - q*yminus1
        return euclid(b, a % b,x,xminus1,y,yminus1)

#main

if __name__ == "__main__":
    if (len(sys.argv) < 3):
        print "Usage: euclid [int a] [int b]"
        sys.exit(-1)

    a = int(sys.argv[1])
    b = int(sys.argv[2])

    print "(b, a%b, q, x, y)"
    (d,x,y) =  euclid(a,b)

    print "(d,x,y) = ", (d,x,y)
