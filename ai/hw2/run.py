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

    #this code snippet can dump tree json to a file
    with open('tree.json', 'w') as outfile:
        json.dump(pruned_tree, outfile)

    print "Generating rules list..."
    rules_list = rules.build_rules_list(schema, pruned_tree, [])
    print "Using rules to classify test data..."
    print "Number of Rules:{0}".format(len(rules_list))
    #we are computing stats based on the criteria of 'correctly identifying <=50K cases'
    #this is to allow us to compute precision and recall, and f-measure
    #correctly guessed <=50k
    true_positive_count = 0
    #incorrectly guessed <=50k
    false_positive_count = 0
    #correctly guessed  >50k
    true_negative_count = 0
    #incorrectly guessed < 50k
    false_negative_count = 0
    total_pos = 0
    total_neg = 0
    total_count = 0
    num_tests = len(test_set)
    for case in test_set:
        total_count += 1
        #print "Classifying {0} of {1} test cases.".format(total_count, num_tests)
        case_classification = case[-1]
        result = classify.rule_classify(schema, rules_list, case)
        if result == case_classification:
            if result == '<=50K':
                true_positive_count += 1
                total_pos += 1
            else:
                true_negative_count += 1
                total_neg += 1
        else:
            if result == '<=50K':
                false_positive_count += 1
                total_neg += 1
            else:
                false_negative_count += 1
                total_pos += 1

    precision, recall, fmeasure = compute_stats(total_count,
                                                total_pos,
                                                total_neg,
                                                true_positive_count,
                                                true_negative_count,
                                                false_positive_count,
                                                false_negative_count)
    print "Precision: {0}, Recall:{1}, F-measure:{2}".format(precision, recall, fmeasure)


def compute_stats(total, totalpos, totalneg, tpos, tneg, fpos, fneg):
    precision = tpos / float(tpos + fpos)
    recall = tpos / float(totalpos)
    fmeasure = 2 * (precision * recall) / (precision + recall)
    return precision, recall, fmeasure


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




