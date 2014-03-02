;Cody Hanson
;CS5820 Artificial Intelligence
;Spring 2014 - Professor Kalita

;returns the right hand side of a rule
(defun rhs (rule)
    (nth 1 rule))

;returns the left hand side of a rule
(defun lhs (rule)
    (nth 0 rule))

;returns true if the argument is a valid rule. false otherwise
(defun ruleP (rule)
  (and (listp (nth 0 rule)) ;first item is a list
       (listp (nth 1 rule)) ;second item is a list
       (null  (nth 2 rule))); and there are only 2 items
  )

;performs a substitution, with the rhs of a rule, 
;and an association list of substitutions
(defun sub (input subs)
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
             (if (equal (car pair) (nth 1 (car input))) 
                 (return (cons (nth 1 pair)  (sub (cdr input) subs)))
             )
         ))
     ;if it is just a nested list, recurse on both the first element, and rest of the list.
     ((listp (car input)) (cons (sub (car input) subs) (sub (cdr input) subs)))
    ))

;Applys a single rule to an arbitrary tree structure.
(defun applyRule (tree rule)
  ;(format t "tree: ~S~%" tree)
  ;(format t "rule: ~S~%" rule)
    ;matches return the applied rule
  (setf matches (match tree (lhs rule))) 
  (cond
    ((not (endp matches)) (sub (rhs rule) matches)) ;there was a match
    (T tree) ;else just return the tree.
    )
  )


;Iterates through a list of rules, applying each of them in order.
;If a rule doesn't match, the tree is passed over unaffected.
(defun applyAllRules (tree rules)
  ;(print 'applyingRules)
  (loop for rule in rules do (setf tree (applyRule tree rule)))
  ;(format t "tree after all rules: ~A~&" tree)
  tree
)

;Iterates through a list of rules, applying the first one that matches
;If a rule doesn't match, the tree is passed over unaffected.
(defun applyOneRule (tree rules)
  ;(print "applying One Rule")
  (loop for rule in rules do 
     (setf newtree (applyRule tree rule))
     ;if the newtree is different, we know a rule was applied. so stop looping
     (if (not (tree-equal tree newtree)) 
       ;if the newTree is a single 1 element list
       ;we want to simplify it and convert it into an atom.
     (progn
       (if (and (eq 1 (list-length newtree)) (atom (car newtree)))
         (setf newtree (car newtree))
       )
       ;now return the tree with the one rule applied
       ;(format t "applying One Rule newtree: ~A~%" newtree)
       (return-from applyOneRule newtree)
     )
     )
  )
  ;otherwise, just return tree, no rules were applied.
  tree
)
 
 
    
;Determines whether a rule matches a given piece of text.
;If so, returns the association list, for the substitution. otherwise, NIL
(defun match (tree lhsrule)
  (let (associations null) 
    (setf pairs (zip-uneven tree lhsrule))
    ;(format t "Match Pairs ~S~%" pairs)
    (loop for pair in pairs do 
     (cond 
      ;if the pairs of atoms are equal, then keep going.
      ((and (atom (nth 0 pair)) (atom (nth 1 pair)) (eq (nth 0 pair) (nth 1 pair))) T)
      ;if the first is an atom, and the next is a substitution,
      ;like (? x),add to the subs
      ((and (atom (nth 0 pair)) 
          (listp (nth 1 pair)) 
          (eq (nth 0 (nth 1 pair)) '?)
          (atom (nth 1 (nth 1 pair)))) (setf associations (cons (list (nth 1 (nth 1 pair)) (nth 0 pair)) associations)))
      ;if the first is a nested list, and the next is a substitution,
      ;like (? x),add to the subs
      ((and (listp (nth 0 pair)) 
          (listp (nth 1 pair)) 
          (eq (nth 0 (nth 1 pair)) '?)
          (atom (nth 1 (nth 1 pair)))) (setf associations (cons (list (nth 1 (nth 1 pair)) (nth 0 pair)) associations)))

      ;if not, abort, they don't match. return an empty subs list
      (T (return-from match null)) ;TODO should this be NIL instead of null?
      ))
    ;(format t "Match Associations: ~S~%" associations)
    (return-from match associations)
  )
)

;Zips together two lists into pairs of items, even if they are not the same length
;padds with NIL if one list is longer.
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

;Opens a filename and reads lines into a list
(defun get-file (filename)
    (with-open-file (stream filename)
      (loop for line = (read-line stream nil)
          while line
          collect line)))


;found this at http://faculty.hampshire.edu/lspector/courses/string-to-list.lisp
;converts a string of items into a list
(defun string-to-list (string)
  "Returns a list of the data items represented in the given list."
  (let ((the-list nil) ;; we'll build the list of data items here
        (end-marker (gensym))) ;; a unique value to designate "done"
    (loop (multiple-value-bind (returned-value end-position)
                               (read-from-string string nil end-marker)
            (when (eq returned-value end-marker)
              (return the-list))
            ;; if not done, add the read thing to the list
            (setq the-list 
                  (append the-list (list returned-value)))
            ;; and chop the read characters off of the string
            (setq string (subseq string end-position))))))

;takes a list of strings, and turns each of them into a list.
;returns the list of lists
(defun process-list-of-strings (stringList)
    (cond 
      ((null stringList) (list))
      (T (cons (string-to-list (car stringList)) (process-list-of-strings (cdr stringList))))
    )
  )


