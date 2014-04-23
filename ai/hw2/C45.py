#! /usr/bin/env python

#This module implements the C4.5 Algorithm for a decision tree classifier
from collections import defaultdict
import math

MINIMUM_SET_SIZE = 5

#super quick implementation of a tree.
Tree = lambda: defaultdict(Tree)


#recursive function to induce a decision tree from a set of training case data.
def induce_tree(s):
    #first check for base cases
    if are_in_same_class(s):
        #base case! return a leaf node.
        return get_class(s[0])
    elif set_is_small(s):
        #set of cases is below the minimum size, take the most common class as a leaf node
        return most_common_class(s)
    else:
        #find the information gain of each attribute
        #and split on the node that has the most information gain
        gains = find_information_gains(s)
        split_node_index = max_gain_index(gains)
        tree = Tree()
        partitions = partition_on_attribute(split_node_index, s)
        for key in partitions.keys():
            tree['decision?'][key] = induce_tree(strip_partition_by_index(split_node_index, partitions[key]))
        return tree


#removes the attribute at 'index' from all tuples. returns list of stripped tuples.
def strip_partition_by_index(index,s):
    stripped = []
    for a_tuple in s:
        tmp = list(a_tuple)
        del tmp[index]
        stripped.append(tuple(tmp))
    return stripped


def find_information_gains(s):
    num_attributes = len(s[0]) - 1 #don't want to include the class
    gains = []
    for i in range(0, num_attributes):
        probabilities = compute_probabilities(s[i])
        gains.append(information_gain(probabilities))
    return gains


#for a given set of probabilities, computes the information gain
def information_gain(probabilities):
    ig = 0
    for p in probabilities:
        ig += - p * math.log(p,2)
    return ig


def compute_probabilities(case):
    pass

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
