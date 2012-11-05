


(defun topreverse (x)
  (cond
    ((null (cdr x)) x)
    ((listp x) (append (topreverse (cdr x)) (list(car x))))))

(defun deepreverse (x)
  (cond
    ((atom x) x)
    ((null (cdr x)) x)
    ((listp x) (append (deepreverse (cdr x)) (list(deepreverse (car x)))))))

