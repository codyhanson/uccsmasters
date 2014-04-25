#! /usr/bin/env python

#python libs
import sys
import json
import random

#my libs
import C45
import rules
import classify



def randomly_divide(data):
    training_set = []
    test_set = []
    for case in data:
        if random.randint(1, 3) in [1, 2]:
            training_set.append(case)
        else:
            test_set.append(case)
    return training_set, test_set


def test_run(schema, data):
    print "Randomly dividing Data into training and test..."
    training_set, test_set = randomly_divide(data)
    print "processing training data to partition continuous attributes..."
    processed_training_tuples = C45.preprocess_continuous_attrs(schema, training_set)
    print "inducing decision tree..."
    tree = C45.induce_tree(schema, processed_training_tuples)
    tree = C45.convert_nested_dd(tree)
    print "Post pruning tree..."
    pruned_tree = C45.prune(tree)
    print "Generating rules list..."
    rules_list = rules.build_rules_list(schema, pruned_tree, [])
    print "Using rules to classify test data..."
    success_count = 0
    failure_count = 0
    total_count = 0
    num_tests = len(test_set)
    for case in test_set:
        total_count += 1
        #print "Classifying {0} of {1} test cases.".format(total_count, num_tests)
        case_classification = case[-1]
        result = classify.rule_classify(schema, rules_list, case)
        if result is case_classification:
            #success
            print "success!"
            success_count += 1
        else:
            #failure
            failure_count += 1
    print "Success:{0}/{1} - {2}%".format(success_count,total_count, (float(success_count)/total_count) * 100)

##############################
#MAIN
##############################

seed = 200
random.seed(seed)
print "Using random seed:{0}".format(seed)

#command line args
schema_file = sys.argv[1]
dataset_file = sys.argv[2]

schema = tuple([raw_line.strip().split(', ') for raw_line in open(schema_file, 'r')][0])
#read in the dataset, stripping newlines from the end. split each record on a comma, into a tuple.
data_tuples = []
for line in [raw_line.strip() for raw_line in open(dataset_file, 'r')]:
    data_tuples.append(tuple(line.split(', ')))

#now data_tuples contains all of our cases, which we will divide randomly into 3 different segments:
#2/3 for training, 1/3 for testing. We'll do this 10 times and compute statistics.

for run in range(1, 10):
    print "---------------------------------------------------------------------------------------"
    print "Beginning Test run: {0}".format(run)
    results = []
    test_run(schema, data_tuples)



#this code snippet can dump tree json to a file
#with open('tree.json','w') as outfile:
#    json.dump(pruned_tree, outfile)

