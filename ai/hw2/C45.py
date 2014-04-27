#! /usr/bin/env python

#This module implements the C4.5 Algorithm for a decision tree classifier
from collections import defaultdict
import math
import re
from numpy import mean

MINIMUM_SET_SIZE = 30

#super quick implementation of a tree.
Tree = lambda: defaultdict(Tree)


#recursive function to induce a decision tree from a set of training case data.
def induce_tree(schema, s):
    #first check for base cases
    if len(schema) is 0 or set_is_small(s):
        #if schema length is zero, it means that there is only one attribute left.
        #and we can't parition anymore.
        #print "Small set base case for {0} {1}".format(schema, s)
        #set of cases is below the minimum size, take the most common class as a leaf node
        return most_common_class(s)
    elif are_in_same_class(s):
        #base case! return a leaf node.
        #print "All same class base case for {0} {1}".format(schema, s)
        return get_class(s[0])
    else:
        #find the information gain of each attribute
        #and split on the node that has the most information gain
        gains = find_information_gains(s)
        split_node_index = max_gain_index(gains)
        #print "Splitting on attr {0} index:{1}".format(schema[split_node_index], split_node_index)
        tree = Tree()
        partitions = partition_on_attribute(split_node_index, s)
        for key in partitions.keys():
            tree[schema[split_node_index]][key] = \
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
    #match int, decimal or unknown value
    continuous_pattern = re.compile('^([\d\.]+|\?)$')
    vals = defaultdict(int)
    for case in cases:
        if len(case) < index:
            pass
        m = re.match(continuous_pattern, case[index])
        if m is None:
            continuous = False
            break
        else:
            vals[m.group(0)] += 1

    #special code to handle the case where there is just '0' and '1'
    if len(vals) == 2 and '0' in vals.keys() and '1' in vals.keys():
        #just a binary column! not continuous
        continuous = False

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
        #print 'Processing {0}'.format(schema[i])
        if not attribute_is_continuous(i, modified_cases):
            #don't need to process this attribute
            continue

        values = [float(case[i]) for case in modified_cases if case[i] is not '?']
        avg_val = mean(values)
        for j in range(0, len(modified_cases)):
            if modified_cases[j][i] == '?':
                #missing attribute, for this case leave it as is.
                continue
            tmp = list(modified_cases[j])
            number_to_compare = float(modified_cases[j][i])
            if number_to_compare <= avg_val:
                tmp[i] = '<=' + str(avg_val)
            else:
                tmp[i] = '>' + str(avg_val)
            modified_cases[j] = tuple(tmp)
    return modified_cases


def compute_probabilities(index, cases):
    probabilities = []
    total = 0.0
    attr_values = defaultdict(int)

    for case in cases:
        #skip missing values
        if case[index] is '?':
            continue
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
    missing = []
    for case in s:
        if case[split_index] == '?':
            missing.append(case)
        else:
            partitions[case[split_index]].append(case)

    #now process the missing cases
    #each case has a missing value for this attribute.
    #we put it in each partition, with the attribute set to the
    #value for that partition
    for case in missing:
        tmp = list(case) #so we can modify the tuple
        for key in partitions.keys():
            tmp[split_index] = key
            updated_case = tuple(tmp)
            partitions[key].append(updated_case)

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


#https://en.wikipedia.org/wiki/Autovivification
def convert_nested_dd(dd):
    '''Converts a nested defaultdict back into a native dictionary.
    '''
    return {k:convert_nested_dd(v) for k,v in dd.items()} if isinstance(dd, defaultdict) else dd


def prune(tree):
    #fist check to see if tree is a simple leaf
    if type(tree) is not dict:
        return tree

    #if all leaf nodes are the same, prune subtree
    leaf_value = all_leaves_same(tree)
    if leaf_value:
        return leaf_value
    else:
        #prune all subtrees
        for k,v in tree.iteritems():
            tree[k] = prune(v)
        leaf_value2 = all_leaves_same(tree)
        if leaf_value2 is None:
            return tree #can't be further pruned
        else:
            return leaf_value2 #remove this whole subtree


#tree has all leaves that are the same.
#if so, return the value of the leaves. otherwise None
def all_leaves_same(tree):
    values = defaultdict(int)
    for k,v in tree.iteritems():
        if (type(v) is dict):
            #nested.
            val = all_leaves_same(v)
            if val is None:
                return None
            else:
                values[val] = 1
        else:
            values[v] = 1
    if len(values) == 1:
        return values.keys()[0] #should only be one key, the leaf value.
    else:
        #not all leaves in the subtree were the same.
        return None

