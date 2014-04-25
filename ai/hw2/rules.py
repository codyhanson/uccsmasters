
#Module which has functions that can format a decision tree as a set of rules
#as well as print rules in an easy to read human format


#this does a depth first traversal of the tree, to build up a list of rules.
#a rule is basically an AND of each state going down a path in the tree,
#culminating in a 'leaf' node which contains the classification for that rule
def build_rules_list(schema, tree, prefix):
    print prefix
    lst = []
    for k, v in tree.iteritems():
        print "k:{0}, v:{1}".format(k, v)
        if type(v) is dict:
            #recurse
            for k2, v2 in v.iteritems():
                if type(v2) is dict:
                    new_prefix = list(prefix) #clone prefix
                    new_prefix.append(dict({k:k2}))
                    lst = lst + build_rules_list(schema,v2,new_prefix) #merge lists
                else:
                    lst.append(prefix + [dict({k:k2}), v2])
        else:
            #leaf!
            print "{0} is leaf!".format(v)
            #for entry in lst:
            #    t = type(entry[-1])
            #    if t is not str and t is not list and k in entry[-1].values():
            #        entry.append(v)
    return lst



#rules is a list of decision tree rules, which themselves are tuples
#that are of the form:
#the ordering of rules is not important,
#since each item in the rule is combined with the name of the object in the schema.
#Schema: (Attribute 1, Atribute 2, ...)
#Rule: ({attribute_1:'attr1 va'}, {attribute_2:'attr2 val'}, ..., CLASSIFICATION)
def print_rules_list(rules):
    pass