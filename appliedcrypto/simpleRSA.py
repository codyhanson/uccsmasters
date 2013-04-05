#! /usr/bin/env python

#simple implementation of RSA encryption/decryption on a number.

import sys

#the numbthy package available here:
#http://userpages.umbc.edu/~rcampbel/Computers/Python/lib/numbthy.py
import numbthy

#my euclidean algorithm
from euclidextended import euclid

if (len(sys.argv) != 5):
    print "Usage: {0} p q e m".format(sys.argv[0])
    sys.exit(1) 

(p,q,e,m) = sys.argv[1:] 

#convert to int
p = int(p)
q = int(q)
e = int(e)
m = int(m)

n = p * q

#compute d using extended euclidean algorithm
phi = numbthy.eulerphi(n)
results = []
results = euclid(e,phi)
d = results[1]
if (d < 0):
    d = d + phi


print "Plaintext input: {0}".format(m)
#encryption of plaintext m into C
C = m**e % n
print "Encryption Result:{0}".format(C)


#decryption of ciphertext C back into M
M = C**d % n
print "Decryption Result:{0}".format(M)
