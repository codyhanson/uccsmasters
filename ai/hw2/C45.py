#! /usr/bin/env python

#This module implements the C4.5 Algorithm for a decision tree classifier
from collections import defaultdict

MINIMUM_SET_SIZE = 20

#super quick implementation of a tree.
Tree = lambda: defaultdict(Tree)

#t = Tree()

#t[1][2][3] = 4
#t[1][3][3] = 5
#t[1][2]['test'] = 6


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
        gains = find_information_gain(s)
        root_index = choose_root(s)
        tree = Tree()
        partitions = partition_on_attribute(root_index,s)
        for partition in partitions:
            tree[root][''] = induce_tree(partition)
        return tree

def find_information_gains(s):
    num_attributes = len(s[0])
    for i in xrange(num_attributes):



def choose_root():
    pass

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
