#! /usr/bin/env python

#This module implements the C4.5 Algorithm for a decision tree classifier
from collections import defaultdict

MINIMUM_SET_SIZE = 20

#super quick implementation of a tree.
Tree = lambda: defaultdict(Tree)

t = Tree()

t[1][2][3] = 4
t[1][3][3] = 5
t[1][2]['test'] = 6

def induce_tree(s):
    #first check for base cases
    if are_in_same_class(s):
        #base case! return a leaf node.
        return get_class(s[0])
    elif set_is_small(s):
        #set of cases is below the minimum size, take the most common class as a leaf node
        return most_common_class(s)
    else:
        pass


def choose_root():
    pass


def get_class(case):
    return case[-1]


def are_in_same_class(cases):
    classes = {}
    for case in cases:
        classes[get_class(case)] = True
    return len(classes) == 1


def set_is_small(cases):
    return len(cases) < MINIMUM_SET_SIZE


def most_common_class(cases):
    classes = defaultdict(int)
    for case in cases:
        classes[get_class(case)] += 1
    most_common = sorted(classes, key=classes.get)[-1]
    return most_common


#https://en.wikipedia.org/wiki/Autovivification
def convert_nested_dd(dd):
    '''Converts a nested defaultdict back into a native dictionary.
    '''
    return {k:convert_nested_dd(v) for k,v in dd.items()} if isinstance(dd, defaultdict) else dd

def prune(tree):
    return tree

tt = convert_nested_dd(t)
pass
