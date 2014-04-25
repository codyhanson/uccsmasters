#! /usr/bin/env python

#This module implements the C4.5 Algorithm for a decision tree classifier
from collections import defaultdict
import math
import re
from numpy import median

MINIMUM_SET_SIZE = 20

#super quick implementation of a tree.
Tree = lambda: defaultdict(Tree)


#recursive function to induce a decision tree from a set of training case data.
def induce_tree(schema, s):
    #first check for base cases
    if len(schema) is 0:
        return 'END'#todo what should happen here?
    elif are_in_same_class(s):
        #base case! return a leaf node.
        print "All same class base case for {0} {1}".format(schema, s)
        return get_class(s[0])
    elif set_is_small(s):
        print "Small set base case for {0} {1}".format(schema, s)
        #set of cases is below the minimum size, take the most common class as a leaf node
        return most_common_class(s)
    else:
        #find the information gain of each attribute
        #and split on the node that has the most information gain
        gains = find_information_gains(s)
        split_node_index = max_gain_index(gains)
        print "Splitting on attr {0} index:{1}".format(schema[split_node_index], split_node_index)
        tree = Tree()
        partitions = partition_on_attribute(split_node_index, s)
        for key in partitions.keys():
            tree[schema[split_node_index].upper()][key] = \
                induce_tree(strip_schema_by_index(split_node_index, schema), strip_partition_by_index(split_node_index, partitions[key]))
        return tree


#removes the attribute at 'index' from all tuples. returns list of stripped tuples.
def strip_partition_by_index(index,s):
    stripped = []
    for a_tuple in s:
        tmp = list(a_tuple)
        del tmp[index]
        stripped.append(tuple(tmp))
    return stripped


def strip_schema_by_index(index, schema):
    tmp = list(schema)
    del tmp[index]
    return tuple(tmp)


def find_information_gains(s):
    num_attributes = len(s[0]) - 1 #don't want to include the class
    gains = []
    for i in range(0, num_attributes):
        probabilities = compute_probabilities(i, s)
        gains.append(information_gain(probabilities))
    return gains


#for a given set of probabilities, computes the information gain
def information_gain(probabilities):
    ig = 0
    for p in probabilities:
        ig += - p * math.log(p, 2)
    return ig


def attribute_is_continuous(index, cases):
    continuous = True
    continuous_pattern = re.compile('[\d\.]+')
    for case in cases:
        if len(case) < index:
            pass
        m = re.match(continuous_pattern, case[index])
        if m is None:
            continuous = False
            break
    return continuous


#this function takes a list of training cases,
#and for each continuous attribute, discretizes it into ranges.
#this then returns the processed set.
#this function should be ran before the training set is passed into induce_tree
def preprocess_continuous_attrs(schema, cases):
    print 'Preprocessing data to get rid of continuous attributes...'
    #iterate over each attribute.
    modified_cases = cases
    for i in range(0, len(modified_cases[0]) - 1):
        print 'Processing {0}'.format(schema[i])
        if not attribute_is_continuous(i, modified_cases):
            #don't need to process this attribute
            continue

        values = [float(case[i]) for case in modified_cases]
        med_val = median(values)
        for j in range(0, len(modified_cases)):
            tmp = list(modified_cases[j])
            number_to_compare = float(modified_cases[j][i])
            if (number_to_compare <= med_val):
                tmp[i] = 'low'
            else:
                tmp[i] = 'high'
            modified_cases[j] = tuple(tmp)
    return modified_cases

def compute_probabilities(index, cases):
    probabilities = []
    total = 0.0
    attr_values = defaultdict(int)

    for case in cases:
        total += 1.0
        attr_values[case[index]] += 1
    for attr_name in attr_values.keys():
        probabilities.append(attr_values[attr_name]/total)
    return probabilities


#returns the index of the highest gain value
def max_gain_index(gains):
    max_index = 0
    max_val = 0
    for i in range(0,len(gains)):
        if gains[i] > max_val:
            max_val = gains[i]
            max_index = i
    return max_index


#partitions the set based on values of the attribute at index 'split_index'.
#a partition will have the same values of the attribute at index
def partition_on_attribute(split_index, s):
    partitions = defaultdict(list)
    for case in s:
        partitions[case[split_index]].append(case)
    return partitions


#in a case tuple, the classification is the last element
def get_class(case):
    return case[-1]


#checks to see if all cases are in the same class.
def are_in_same_class(cases):
    classes = {}
    for case in cases:
        classes[get_class(case)] = True
    return len(classes) == 1


#checks to see if the set of cases is below some minimum size
def set_is_small(cases):
    return len(cases) < MINIMUM_SET_SIZE


#returns the most common class for the set of cases
def most_common_class(cases):
    classes = defaultdict(int)
    for case in cases:
        classes[get_class(case)] += 1
    most_common = sorted(classes, key=classes.get)[-1]
    return most_common

#given a set of values for a continuous attribute, return a set of ranges which partition the space
def partition_continuous_value(set_of_values):
    pass

#https://en.wikipedia.org/wiki/Autovivification
def convert_nested_dd(dd):
    '''Converts a nested defaultdict back into a native dictionary.
    '''
    return {k:convert_nested_dd(v) for k,v in dd.items()} if isinstance(dd, defaultdict) else dd

def prune(tree):
    return tree

#tt = convert_nested_dd(t)
#pass
