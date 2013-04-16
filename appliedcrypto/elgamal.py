#! /usr/bin/env python

#homework problem 10.6

#part a)
q = 71
alpha = 7
k = 2
M = 30
Yb = 3

#compute ciphertex of M
#compute 1 time Key K
K = (Yb ** k) % q
C1 = (alpha**k) % q
C2 = (K * M) % q

print "Encrypting M = {0}: (C1,C2)=({1},{2})".format(M,C1,C2) 


#now A chooses k = 2, M is still 30, (C1,C2) = (59,C2). What is C2?
#k = ??
C1 = 59

#need to derive little k from 
#C1 = (alpha**k) % q
#this is the computation of the discrete logarithm.
#Lets brute force it! q is only 71

for i in xrange(1,q):
    if ((alpha**i) % q == C1):
        k = i
        print "k = {0}".format(i)
        break


#need to recompute the Big K
#now that we've found little k
K = (Yb ** k) % q

#Recompute C2
C2 = (K * M) % q

print "New C2 for C1 = 59, and M = 30: C2={0}, k ={1}".format(C2,k)

