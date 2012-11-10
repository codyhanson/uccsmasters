;Cody Hanson
;CS3160 Problem 2

(terpri)
(format t "Problem 2")
(terpri)

(defun topreverse (x)
  (cond
    ((atom x) x)
    ((null (cdr x)) x) 
    ((listp x) (append (topreverse (cdr x)) (list(car x))))))

(defun deepreverse (x)
  (cond
    ((atom x) x)
    ((null (cdr x)) (list (deepreverse (car x))))
    ((listp x) (append (deepreverse (cdr x)) (list(deepreverse (car x)))))))


(format t "Test 1: Topreverse, then Deepreverse.")
(print (topreverse (list 'a 'b 'c 'd)))
(print (deepreverse (list 'a 'b 'c 'd)))
(terpri)

(format t "Test 2: Topreverse, then Deepreverse.")
(print (topreverse (list (list 'a 'b) (list (list'c 'd (list 'x (list 'y 'z))) 'e) 'f 'g)))
(print (deepreverse (list (list 'a 'b) (list (list'c 'd (list 'x (list 'y 'z))) 'e) 'f 'g)))
(terpri)

(format t "Test 3: Topreverse, then Deepreverse.")
(print (topreverse 'a))
(print (deepreverse 'a))
(terpri)

(format t "Test 4: Topreverse, then Deepreverse.")
(print (topreverse (list)))
(print (deepreverse (list)))
(terpri)
