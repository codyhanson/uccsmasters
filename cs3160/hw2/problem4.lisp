

;if the current index is less than the index i want to insert into
;go to the next item in the list
;if the current index is greater than the index I want to insert into
;insert a new node before this index.
;if the current index id equal, then update this item.

(defun setval (alist index val)
  (cond 
  ((null val) alist) ;nil value, return unmodified list
  ((null alist)  (list (list index val)))
  ((< index (car (car alist))) (cons (list index val) alist ))
  ((> index (car (car alist))) (cons (car alist) (setval (cdr alist) index val)))
  ((= index (car (car alist))) (list (list index val) (cdr alist)))))

(defun getval (alist index)
  (cond
  ((null alist) nil)
  ((null index) nil)
  ((= index (car (car alist))) (cdr (car alist)))
  (T (getval (cdr alist) index))))

(defun size (mylist)
  (cond
  ((null mylist) nil)
  ((null (cdr mylist)) (car (car mylist)))
  (T (size (cdr mylist)))))


(defun compress (mylist)
  (cond 
  ((null mylist) nil)
  (T (cons (list (1) (cdr (car mylist))) (compress (cdr mylist))))))


;(defun display (mylist all)
;  (cond
;  ((null alist) nil)
;  ((null index) nil)
;  ((= index (car (car alist))) (cdr (car alist)))
;  (T (display(cdr alist) index))))

(setf x (setval nil 10 8))
(print x)
(setf x (setval x 5 6))
(print x)
(setf x (setval x 1 4))
(print x)
(setf x (setval x 2 10))
(print x)
(setf x (setval x 7 25))
(print x)
(setf x (setval x 8 nil))
(print x)

(print (getval x 1))
(print (getval x 3))
(print (getval x 5))

(print (size x))




;(defun swap (mylist x y)

;)

;(defun bubblesort (mylist)

;)
