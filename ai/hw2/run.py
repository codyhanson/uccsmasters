#! /usr/bin/env python

import sys

#command line args
training_data_file = sys.argv[1]
test_data_file = sys.argv[2]

#read in the dataset, stripping newlines from the end.
training_data = [line.strip() for line in open(training_data_filename, 'r')]
test_data = [line.strip() for line in open(test_data_filename, 'r')]

#split each record on a comma, into a tuple.
