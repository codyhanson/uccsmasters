


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

(print (topreverse (list 'a 'b 'c 'd)))
(print (deepreverse (list 'a 'b 'c 'd)))

(print (topreverse (list (list 'a 'b) (list (list'c 'd (list 'x (list 'y 'z))) 'e) 'f 'g)))
(print (deepreverse (list (list 'a 'b) (list (list'c 'd (list 'x (list 'y 'z))) 'e) 'f 'g)))

(print (topreverse 'a))
(print (deepreverse 'a))

(print (topreverse (list)))
(print (deepreverse (list)))
