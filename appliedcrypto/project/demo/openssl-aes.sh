#! /bin/bash

INFILE="$2"
OUTFILE="$3"

if [ "$1" == "encrypt" ]
then
    echo 'Encrypting $$INFILE to file: $$OUTFILE'
    openssl aes-256-cbc -e -in $INFILE  -out $OUTFILE -base64 -k password -md sha 
elif [ "$1" == "decrypt" ]
then
    echo 'Decrypting  $2 to file: $3'
    openssl aes-256-cbc -d -in $INFILE -out $OUTFILE -base64 -k password -md sha 
fi
