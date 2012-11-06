;HW2 Problem 1

(defun len (x)
	(cond
	((null x) 0)
	((atom x) 1)
	(t (+ 1 (len (cdr x))))))

(setf l1 (list 'a 'b 'c 'd))
(print l1)
(print (len l1))

(setf l2 (list (list 'a 'b) (list (list'c 'd (list 'x (list 'y 'z))) 'e) 'f 'g))
(print l2)
(print (len l2))

(setf l3 'a)
(print l3)
(print (len l3))

(print (list))
(print (len (list)))
