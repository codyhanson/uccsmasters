#! /usr/bin/env python

#which values of the affine cipher a,b do not produce a one-to-one mapping?

a = 3
b = 2
for a in range(-50,50):
    mapping = {}
    for p in range(0,26):
        c = (a*p + b) % 26
        if not (c in mapping.values()):
           mapping[p] = c 
        else:
            #there was a conflict for this config
            for p2,c2 in mapping.iteritems():
                if c == c2:
                   otherP = p2 
            print "not one to one for p = {0}, a = {1}, b = {2}. c = {3}, other p = {4}".format(p,a,b,c,otherP)
            break

