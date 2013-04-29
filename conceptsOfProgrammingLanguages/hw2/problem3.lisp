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
  (T (if (equal (car y) (car x)) 
    (contains (cdr x) (cdr y))
    (contains x (cdr y))))))

;returns true if x is composed of only atoms
;returns nil if there is a nested list
(defun atomsonly (x)
  (if (null x) 
    T 
    (if (atom (car x))
      (atomsonly (cdr x))
      nil)))

;'main' loop to take in input for x and y
;commented so that I can run the automated tests.
;(format t "Please Input Y:")
;(setq y (read))
;now get X and compute if X is in Y
;(format t "Please Input X:")
;(loop while (setq x (read)) do
;  (print (contains x y)) 
;  (terpri)
;  (format t "Please Input X:"))


;this code will run to automate running of tests
(format t " ~%Problem 3 Tests: Part 1 ~&")
(setf y (list (list 1) 'a 'b 'c (list 2) 'd 'e))
(format t "Y is:")
(print y)
(terpri)

(setf x (list 'a))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-1: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'b 'c))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-2: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'a 'b 'c))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-3: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'b 'c 'd))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-4: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(format t "X is:")
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-5: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'd))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-6: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'e))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-7: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'a 'b (list 'c)))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 1-8: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x 'a)
(format t "X is:  ~a ~&" x)
(format t "Test Result 1-9: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x nil)
(format t "X is: (NIL) ~&")
(format t "Test Result 1-10:")
(print (contains x y))
(terpri)

(format t " ~%Problem 3 Tests: Part 2 ~&")
(setf y (list 'a 'b 'c 'd (list 1) 'e 'f (list 2) 'g))
(format t "Y is:")
(print y)
(terpri)
(terpri)

(setf x (list 'a))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 2-1: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'd))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 2-2: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'e 'f))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 2-3: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'e 'f 'g))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 2-4: ( ~{~a~^, ~} ) ~&~%" (contains x y))

(setf x (list 'b 'c))
(format t "X is: ( ~{~a~^, ~} ) ~&" x)
(format t "Test Result 2-5: ( ~{~a~^, ~} ) ~&~%" (contains x y))




