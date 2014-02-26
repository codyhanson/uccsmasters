;Cody Hanson
;CS5820 Artificial Intelligence
;Spring 2014 - Professor Kalita


(defun rhs (rule)
    (nth 1 rule))

(defun lhs (rule)
    (nth 0 rule))

(defun ruleP (rule)
  (and (listp (nth 0 rule)) ;first item is a list
       (listp (nth 1 rule)) ;second item is a list
       (null  (nth 2 rule))); and there are only 2 items
  )


(defun sub (input subs)
   ;check the first token to decide how to recurse
   ;(print '------)
   ;(print subs)
   ;(print input)
   ;(print (car input))
   ;(print (cdr input))
   (cond
     ;if no input, nothing to do.
     ((null input) NIL)
     ;if no subs, just return the input
     ((null subs) input)
     ;if it is a simple word, just keep going.
     ((atom (car input)) (cons (car input) (sub (cdr input) subs)))
     ;if it is a nested list, and also a replacement marker (? something), do replacement
     ((and (listp (car input)) (equal (car (car input)) '?)) 
         (loop for pair in subs do
            ; (print '-loop-)
            ; (print pair )
            ; (print (car pair ))
            ; (print (nth 1 (car input)))
             (if (equal (car pair) (nth 1 (car input))) 
                 (return (cons (nth 1 pair)  (sub (cdr input) subs)))
             )
         ))
     ;if it is just a nested list, recurse on both the first element, and rest of the list.
     ((listp (car input)) (cons (sub (car input) subs) (sub (cdr input) subs)))
    ))

(defun applyRule (tree rule)
    ;matches return the applied rule
  (setf matches (match tree (lhs rule))) 
  (cond
    ((not (endp matches)) (sub (rhs rule) matches)) ;there was a match
    (T tree) ;else just return the tree.
    )
  )
    

(defun match (tree lhsrule)
  (let (associations null) 
    (setf pairs (zip-uneven tree lhsrule))
    (print pairs)
    (loop for pair in pairs do 
     ;(print '-----1)
     ;(print associations)
     ;(print pair) 
     (cond 
      ;if the pairs of atoms are equal, then keep going.
      ((and (atom (nth 0 pair)) (atom (nth 1 pair)) (eq (nth 0 pair) (nth 1 pair))) (print 'keepgoing))

      ;if the first is an atom, and the next is a substitution,
      ;like (? x),add to the subs
      ((and (atom (nth 0 pair)) 
          (listp (nth 1 pair)) 
          (eq (nth 0 (nth 1 pair)) '?)
          (atom (nth 1 (nth 1 pair)))) (setf associations (cons (list (nth 1 (nth 1 pair)) (nth 0 pair)) associations)))
      ;if not, abort, they don't match. return an empty subs list
      (T (return-from match null))
      ))
    (print associations)
    (return-from match associations)
  )
)

(defun zip-uneven (list1 list2)
  (cond
    ((and (endp list1) (endp list2)) '()) ;base case. return empty list.
    ((and (endp list1) (not (endp list2)))  ;list2 is longer than list1
      (cons (list NIL (car list2)) (zip-uneven NIL (cdr list2))))
    ((and (not (endp list1)) (endp list2)) ;list1 is longer than list2
      (cons (list (car list1) NIL) (zip-uneven (cdr list1) NIL)))
    (T  ;both the same length
      (cons (list (car list1) (car list2)) (zip-uneven (cdr list1) (cdr list2))))
    )
  )

;Main program.

;(setf result (sub '(color (? x) (? y)) '((x apple) (y red))))
;(print '---------)
;(print 'result)
;(print result)

;(setf result (sub '(color ((? y) so very (? x)) word (? y)) '((x apple) (y red))))
;(print '---------)
;(print 'result)
;(print result)

;(setf result (match '(socrates man) '((? x) mortal)))
;(print '---------)
;(print 'result)
;(print result)


(setf result (zip-uneven '(1 2 3) '(1 2 3 4 5 6)))
(print '---------)
(print 'result)
(print result)

(setf result (zip-uneven '(1 2 3) '(4 5 6)))
(print '---------)
(print 'result)
(print result)

(setf result (zip-uneven '(1 2 3 3 2 1) '(4 5 6)))
(print '---------)
(print 'result)
(print result)





(setf result (applyRule '(socrates man) '((socrates (? x)) (is (? x)))))
(print '---------)
(print 'result)
(print result)

(setf result (applyRule '(socrates is a man) '((socrates (? x)) (is (? x)))))
(print '---------)
(print 'result)
(print result)

