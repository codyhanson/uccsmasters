;Cody Hanson
;Problem 4
;CS3160 Fall 2012

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
  ((= index (car (car alist))) (cons (list index val) (cdr alist)))))

(defun getval (alist index)
  (cond
  ((null alist) nil)
  ((null index) nil)
  ((= index (car (car alist))) (car (cdr (car alist))))
  (T (getval (cdr alist) index))))

(defun size (mylist)
  (cond
  ((null mylist) nil)
  ((null (cdr mylist)) (car (car mylist)))
  (T (size (cdr mylist)))))


(defun compress (mylist)
  (setf indx 1)
  (setf newlist (list))
  (loop
    (if (null newlist)
      (setf newlist (list (list indx (car (cdr (car mylist))))))
      (setf newlist (append newlist (list (list indx (car (cdr (car mylist))))))))
    (setf mylist (cdr mylist))
    (setf indx (+ indx 1))
  (when (null mylist) (return newlist))))

(defun swap (mylist x y)
  (setf xval (getval mylist x))
  (setf yval (getval mylist y))
  (setf mylist (setval mylist x yval)) ;set X to Y
  (setf mylist (setval mylist y xval))) ;set Y to X


(defun bubblesort (mylist)
  (setf mylist (compress mylist))
  (loop for i from (size mylist) downto 1 do 
   (loop for j from 1 to i do
     (progn
     (if (< (getval mylist i) (getval mylist j)) 
     (setf mylist (swap mylist i j)))))) 
  (car (list mylist)))

(defun display (mylist all)
  (setf indx 1)
  (setf size (size mylist))
  (loop
    (if (= indx (car (car mylist))) ;if the next item in the list is our index
      (progn
       (format t "~d: ~a ~%" indx (car (cdr (car mylist))))
        (setf mylist (cdr mylist)))
      (if (not (null all)) ;else
        (format t "~d: NIL ~%" indx))) 
    (setf indx (+ indx 1))
  (when (> indx size) (return))))

(format t "~%setval: adding (10,8)")
(setf x (setval nil 10 8))
(print x)
(format t "~%setval: adding (5,6)")
(setf x (setval x 5 6))
(print x)
(format t "~%setval: adding (1,4)")
(setf x (setval x 1 4))
(print x)
(format t "~%setval: adding (2,10)")
(setf x (setval x 2 10))
(print x)
(format t "~%setval: adding (7,25)")
(setf x (setval x 7 25))
(print x)
(format t "~%setval: adding (8,NIL)")
(setf x (setval x 8 nil))
(print x)

(format t "~%Getval 1,3,5:")
(print (getval x 1))
(print (getval x 3))
(print (getval x 5))

(format t "~%Size of X:")
(print (size x))

(format t "~%swap 1, 5:")
(setf x (swap x 1 5))
(print x)
(format t "~%swap 7, 10:")
(setf x (swap x 7 10))
(print x)
(format t "~%swap 6, 8:")
(setf x (swap x 6 8))
(print x)

(format t "~%~%Display All=nil and All=T:~%")
(display x nil)
(terpri)
(display x T)


(format t "~%~%compress:")
(print (compress x))

(format t "~%~%Bubble sort: ")
(print (bubblesort x))
