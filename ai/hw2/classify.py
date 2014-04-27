
import re

all_caps = re.compile(r'^[A-Z-]+$')
continuous_val = re.compile('^(>|<=)([\d\.]+)$')
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

def is_continuous(rule_clause):
    m = re.match(continuous_val, rule_clause[1])
    if m is None:
        return None
    comparison = m.group(1)
    value = m.group(2)
    return comparison, value


def rule_classify(schema, rules, case):
    rule_counter = 0
    rule_count = len(rules)
    for rule in rules:
        #print "trying rule {0} of {1}".format(rule_counter,rule_count)
        rule_counter += 1
        rule_match = True
        for i in range(0, len(rule) -1):
            idx = schema.index(rule[i][0]) #index of this attribute
            #we need to check if this rule is a continuous value.
            #and handle it differently than if it was discreet.
            cv = is_continuous(rule[i])
            if cv is not None:
                #we need to do the compare a special way
                if cv[0] == '>' and case[idx] <= cv[1]:
                    #this rule doesn't match
                    rule_match = False
                    break
                elif cv[0] == '<=' and case[idx] > cv[1]:
                    #this rule doesn't match
                    rule_match = False
                    break
            #or test if the case's attribute matches the value in the rule (non continuous vals).
            elif case[idx] != rule[i][1]:
                #this rule doesn't match
                rule_match = False
                break
        if rule_match:
            #found a match, return the classification deemed by the rule
            #print "Found a match!"
            return rule[-1]
    return None
