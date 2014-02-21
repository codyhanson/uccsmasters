
import re

test_rule = ["", ""]


#by convention a rule is of the form [lhs,rhs]

def rhs(rule):
    if rule_p(rule):
        return rule[1]
    else:
        return None


def lhs(rule):
    if rule_p(rule):
        return rule[0]
    else:
        return None



#Checks whether a given input is a valid 'rule' or not.
#rule is defined as a list of two patterns.
def rule_p(rule):
    if rule is not None and len(rule) == 2 \
            and isinstance(rule[0], basestring) \
            and isinstance(rule[1], basestring):
        return True
    else:
        return False

#pattern looks like this
#("some", "non-replaceable", "stuff", ("?", "a"), ("?", "b"))
#and the replacement list looks like
#(("a", "replaced the a"), ("b", "replaced the b")
# and then after replacement, it looks like
#("some", "non-replaceable", "stuff", "replaced the a", "replaced the b")
def substitute(pattern_list,replacement_list):
    pattern_re = '\(?[0-9a-zA-Z]+)(.*?)'
    patterns = []
    while 1:
        match = re.search(pattern_re, pattern)
        if match:
            patterns.append(match.group(1))
            pattern = match.group(2)
        else:
            #no more patterns in the pattern string.
            break

    #patterns is now a list of the replacement patterns.

    #then substitute them with their replacements.

    for a_pattern in patterns:
        re.sub
    pass

def apply_rule(tree, rule):
    pass


def main():
    print rule_p(rule)
    print rhs(rule)
    print lhs(rule)



















if __name__ == "__main__":
    main()