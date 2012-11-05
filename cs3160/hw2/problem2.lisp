


(defun topreverse (x)
  (cond
    ((null (cdr x)) x)
    ((listp x) (append (topreverse (cdr x)) (list(car x))))))

