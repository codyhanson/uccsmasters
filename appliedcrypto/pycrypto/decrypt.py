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
#inputname = "declaration.txt.{0}".format(passPhraseName)
outputname = "{0}-decrypted.txt".format(inputname)

#obtain ciphertext 
fh = open(inputname)
ciphertext = fh.read()
fh.close()

#encrypt the cleartext and write to a file
#use the MD5 of the passphrase as the key
enckey = hashlib.sha256(passPhrase).digest()
aes = AESCipher(enckey)
cleartext = aes.decrypt(ciphertext)

#truncate file if it exists
outfile = open(outputname,'w+')
outfile.write(cleartext) 
outfile.close()
print "Completed"

