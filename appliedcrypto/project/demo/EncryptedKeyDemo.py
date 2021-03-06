#! /usr/bin/env python

import sys
from boto.s3.connection import S3Connection
from boto.s3.encryptedkey import EncryptedKey
from boto.s3.key import Key 


sys.stdout.write("Establishing connection to Amazon S3...")
conn = S3Connection()
print "done"


sys.stdout.write("Creating a bucket...")
bucket = conn.create_bucket('cody-test-bucket')
print "done"

passkey = 'password'
keyname = 'declaration.txt'

sys.stdout.write("Putting encrypted content to S3...")
ekey = EncryptedKey(bucket,keyname,passkey)
sys.stdout.write("key created...")
ekey.set_contents_from_filename('./declaration.txt')
print "done"


sys.stdout.write("getting encrypted content to with a regular key...")
plainkey = Key(bucket,keyname)
print "done"
plainkey.get_contents_to_filename('./declaration-encrypted.txt')

sys.stdout.write("getting content and automatically decrypting with an EncryptedKey...")
#ekey.get_contents_to_filename('./declaration-decrypted-boto')
ekeyfp = open('./declaration-decrypted.txt','wb')
ekey.get_contents_to_file(ekeyfp)
ekeyfp.close()
print "done"
