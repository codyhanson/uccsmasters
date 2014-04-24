#! /usr/bin/env python

#python libs
import sys
import json
#my libs
import C45
import classify

#command line args
schema_file = sys.argv[1]
training_data_file = sys.argv[2]
#test_data_file = sys.argv[3]

schema = tuple([raw_line.strip().split(', ') for raw_line in open(schema_file, 'r')][0])
#read in the dataset, stripping newlines from the end. split each record on a comma, into a tuple.
training_tuples = []
for line in [raw_line.strip() for raw_line in open(training_data_file, 'r')]:
    training_tuples.append(tuple(line.split(', ')))


processed_training_tuples = C45.preprocess_continuous_attrs(schema, training_tuples)

tree = C45.induce_tree(schema, processed_training_tuples)
print json.dumps(tree, indent=1)
pruned_tree = C45.prune(tree)

#then we can format the pruned tree as a list of rules.

#classification = classify.classify(tree,example)