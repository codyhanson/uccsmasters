import numpy as np
# input is a numpy.polynomial.Polynomial
def prettyprint(poly):
    coeff = []
    for c in poly:
       coeff.append(int(c)) 
    coeff.reverse()
    print np.poly1d(coeff)


