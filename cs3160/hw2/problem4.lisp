

;if the current index is less than the index i want to insert into
;go to the next item in the list
;if the current index is greater than the index I want to insert into
;insert a new node before this index.
;if the current index id equal, then update this item.

(defun setval (alist index val)
  (print alist)
  (print index)
  (print val)
  (cond 
  ((= nil val) alist) ;nil value, return unmodified list
  ((null alist)  (list (list index val)))
  ((null (cdr alist)) (list (car alist) (list index val))) 
  ((< index (car (car alist))) (setval (cdr alist) index val))
  ((> index (car (car alist))) (list (car alist ) (list index val) (cdr alist)))
  ((= index (car (car alist))) (list (list index val) (cdr alist)))))


;(defun getval (alist index)

;)

;(defun display (mylist all)

;)

;(defun compress (mylist)

;)

;(defun size (mylist)

;)

;(defun swap (mylist x y)

;)

;(defun bubblesort (mylist)

;)
