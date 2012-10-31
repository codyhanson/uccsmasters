;Cody Hanson
;CS3160 Fall 2012
;HW2 Problem 1

(defun deeplen (x)
	(cond
	((null x) 0)
	((atom x) 1)
	(t (+ (len (car x)) (deeplen (cdr x))))))

(princ "starting testing for problem 1\n")
(princ "test 1\n")
(setf listone (list 1 2 3 4))
(princ "first input: l1. 4 atoms, should get deeplen = 4\n")
(princ "listone = ")
(print listone)
(princ "deeplen got:")
(print (deeplen listone))

(princ "test 2")
(setf listtwo (list (list 'a 'b) (list (list 'c 'd (list 'x (list 'y 'z))) 'f 'g))
(princ "first input: embedded lsits, should get deeplen = 10")
(princ "listtwo = ")
(print listtwo)
(princ "deeplen got:")
(print (deeplen listtwo))
