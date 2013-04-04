#! /usr/bin/env python

import hashlib
from AESCipher import AESCipher
import sys

if (len(sys.argv) < 2):
    print "need a filename"
    exit(1)

inputname = sys.argv[1]

passPhraseName= "MyPhraseName"
passPhrase = "rosebud"

#obtain cleartext
fh = open(inputname)
if (fh == None):
    print "bad filename"
    exit(1)

cleartext = fh.read()
fh.close()

#encrypt the cleartext and write to a file
#use the MD5 of the passphrase as the key
enckey = hashlib.sha256(passPhrase).digest()
aes = AESCipher(enckey)
ciphertext = aes.encrypt(cleartext)

#truncate file if it exists
outfile = open("{0}.{1}".format(inputname,passPhraseName),'w+')
outfile.write(ciphertext) 
outfile.close()
print "Completed"
