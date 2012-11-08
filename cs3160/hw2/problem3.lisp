;Cody Hanson
;CS 3160
;UCCS Fall 2012
;Problem 3 hw 2
;11/4/2012


(defun contains (x y)
  (cond 
  ((null y) nil)
  ((not (listp y)) nil)
  ((not (listp x)) nil)
  ((null x) y)
  ((not(atomsonly x)) nil)
  ((equal (car y) (car x))(contains (cdr x) (cdr y)))
  (T (contains x (cdr y)))))

;returns true if x is composed of only atoms
;returns nil if there is a nested list
(defun atomsonly (x)
  (if (null x) 
    T 
    (if (atom (car x))
      (atomsonly (cdr x))
      nil)))

;'main' loop to take in input for x and y
(format t "Please Input Y:")
(setq y (read))
;now get X and compute if X is in Y
(format t "Please Input X:")
(loop while (setq x (read)) do
  (print (contains x y)) 
  (terpri)
  (format t "Please Input X:"))

