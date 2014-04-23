#! /usr/bin/env python

#python libs
import sys

#my libs
import C45
import classify

#command line args
training_data_file = sys.argv[1]
test_data_file = sys.argv[2]

#read in the dataset, stripping newlines from the end. split each record on a comma, into a tuple.
training_tuples = []
for line in [raw_line.strip().rstrip() for raw_line in open(training_data_file, 'r')]:
    training_tuples.append(tuple(line.split(',')))



tree = C45.induce_tree(training_tuples)
pruned_tree = C45.prune(tree)
pass

#classification = classify.classify(tree,example)