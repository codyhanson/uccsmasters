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


(setf result (sub '(color (? x) (? y)) '((x apple) (y red))))
(print '---------)
(print 'result)
(print result)

(setf result (sub '(color ((? y) so very (? x)) word (? y)) '((x apple) (y red))))
(print '---------)
(print 'result)
(print result)


;(defun applyRule (tree rule)
;  (cond 
;    ;matches return the applied rule
;    ((matches tree (lhs rule)) (sub (rhs rule) tree) 
;    ;otherwise just return the tree
;    (T tree) 
;  )
;)

;(defun matches ()

;  )
