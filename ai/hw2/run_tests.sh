#! /usr/bin/env bash

#the python -u flag makes tee work.
time python -u ./run.py dataset/adult/adult.schema dataset/adult/adult.data | tee paper/adult_output.txt
time python -u ./run.py dataset/ad/ad.schema dataset/ad/ad.data | tee paper/ad_output.txt

