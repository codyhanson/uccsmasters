#! /usr/bin/env python

import hashlib
from AESCipher import AESCipher

passPhraseName= "MyPhraseName"
passPhrase = "rosebud"
inputname = "declaration.txt"

#obtain cleartext
fh = open(inputname)
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

