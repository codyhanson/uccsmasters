#! /usr/bin/env python

#attempt to do a symmetrical block cipher
#using a 1 way hash function


import hashlib
#from BitVector import BitVector as bv

#want a 16 byte input size
ptext = "012345679abcdeff012345679abcdeff"
ptexthash = hashlib.md5()
ptexthash.update(ptext)
sharedkey = ptexthash.hexdigest()

print ptext

#convert the strings to bytes so we can XOR
ptextbytes = int(ptext,16)
sharedkeybytes = int(sharedkey,16)

ciphertext = ptextbytes ^ sharedkeybytes
print ciphertext


print "decrypt"
print '{0:x}'.format(ciphertext)
#now decrypt

ptext2 = sharedkeybytes ^ ciphertext
print '{0:x}'.format(ptext2)

#don't think its working currently...
