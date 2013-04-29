;HW2 Problem 1

(format t "Problem 1")
(terpri)

(defun len (x)
	(cond
	((null x) 0) ;done counting
	((atom x) 1)
	(t (+ 1 (len (cdr x)))))) ;recurse to the rest of the list

(format t "Test 1:")
(setf l1 (list 'a 'b 'c 'd))
(print l1)
(print (len l1))
(terpri)

(format t "Test 2:")
(setf l2 (list (list 'a 'b) (list (list'c 'd (list 'x (list 'y 'z))) 'e) 'f 'g))
(print l2)
(print (len l2))
(terpri)

(format t "Test 3:")
(setf l3 'a)
(print l3)
(print (len l3))
(terpri)

(format t "Test 4:")
(print (list))
(print (len (list)))
(terpri)
