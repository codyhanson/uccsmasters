
import re

all_caps = re.compile(r'^[A-Z-]+$')
#given a decision tree and an example, return the determined classification for the unknown example.
"""
def classify(schema, tree, case, index):
    for k, v in tree.iteritems():
        if re.match(all_caps, k):
            #a label node. just skip it and
            #recurse on its children
            return classify(schema, v, case, schema.index(k))
        elif :
            pass
    pass
"""


def rule_classify(schema, rules, case):
    rule_counter = 0
    rule_count = len(rules)
    for rule in rules:
        #print "trying rule {0} of {1}".format(rule_counter,rule_count)
        rule_counter += 1
        rule_match = True
        for i in range(0, len(rule) -1):
            idx = schema.index(rule[i][0])
            if case[idx] is not rule[i][1]:
                #this rule doesn't match
                rule_match = False
                break
        if rule_match:
            #found a match, return the classification deemed by the rule
            print "Found a match!"
            return rule[-1]
    return None
