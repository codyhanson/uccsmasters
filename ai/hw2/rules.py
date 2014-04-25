
#Module which has functions that can format a decision tree as a set of rules
#as well as print rules in an easy to read human format


#this does a depth first traversal of the tree, to build up a list of rules.
#a rule is basically an AND of each state going down a path in the tree,
#culminating in a 'leaf' node which contains the classification for that rule
def build_rules_list(schema, tree, prefix):
    lst = []
    for k, v in tree.iteritems():
        if type(v) is dict:
            #recurse
            for k2, v2 in v.iteritems():
                if type(v2) is dict:
                    #clone the prefix so we can modify it
                    new_prefix = list(prefix)
                    new_prefix.append(tuple([k,k2]))
                    #merge lists
                    lst = lst + build_rules_list(schema, v2, new_prefix)
                else:
                    lst.append(prefix + [tuple([k, k2]), v2])
    return lst


#rules is a list of decision tree rules, which themselves are tuples
#that are of the form:
#the ordering of rules is not important,
#since each item in the rule is combined with the name of the object in the schema.
#Schema: (Attribute 1, Atribute 2, ...)
#Rule: ({attribute_1:'attr1 va'}, {attribute_2:'attr2 val'}, ..., CLASSIFICATION)
def print_rules_list(rules):
    pass