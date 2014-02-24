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
   (cond
     ;if it is a simple word, just keep going.
     ((atom (car input)) (cons (car input) (sub (cdr input) subs)))
     ;if it is a nested list, and also a replacement marker (? something), do replacement
     ((and (listp (car input)) (equal (car input) '?)) 
         (loop for sub in subs do
             (if (equal (car sub) (nth 1 input)) sub)
         ))
     ;if it is just a nested list, recurse on both the first element, and rest of the list.
     ((listp (car input)) (cons (sub (car input) subs) (sub (cdr input) subs)))
    ))


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
