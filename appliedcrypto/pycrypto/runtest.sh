#! /bin/bash

./encrypt.py declaration.txt
./decrypt.py declaration.txt.MyPhraseName
md5sum declaration.txt
md5sum declaration.txt.MyPhraseName-decrypted.txt
