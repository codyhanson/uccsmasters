#! /usr/bin/env python

#effecient modular exponentiation algorithm
#from page 283, Stallings crypto book 5th ed.
#computes a^b mod n

# inputs: a, b, n

from BitVector import BitVector as bv

k = 10
a = 5
b = bv(intVal=596, size=k)
n = 1234



print "Performing fast modular exponentiation"
print "a:{0}, b:{1}, n:{2}".format(a,b,n)
c = 0
f = 1
for i in reversed(xrange(k)):
    j = k- 1 - i #to fix the wierd indexing in BitVector
    print "i:{3}, f:{0}, c:{1}, bi:{2}".format(f,c,b[j],i)
    c = 2 * c
    f = (f * f) % n
    if (b[j] == 1):
        c = c + 1
        f = (f * a) % n


print "result = " ,f
