; Symbolic Differentiation, using rules_engine.lisp
; Cody Hanson
; Spring 2014 - CS5860-AI UCCS

;import the rules engine functions
(load "rules_engine.lisp")

;load the rules.
(setf ruleStrings (get-file "./derivativerules"))
(setf rulesList (process-list-of-strings ruleStrings))
(print rulesList)

;returns true if a list is a single level deep.
(defun flat-list (aList)
  (if (atom aList) 
    (return-from flat-list NIL))
  (loop for item in aList do
    (cond
      ((not (atom item)) (return-from flat-list NIL))
    )
  )
  T
)

;Define our derivative function.
(defun ddx (expression rulesList)
  (terpri)
  (format t "expression: ~S~%" expression)
  (cond
    ;the order of rules is important.
    ((null expression) NIL)
    ((atom expression) (applyOneRule expression rulesList))
    ((flat-list expression)
      (print "flat list Expression")
      (applyOneRule expression rulesList))
    ((flat-list (car expression))
      (print "flatlist Car Expression")
      (cons (applyOneRule (car expression) rulesList) (ddx (cdr expression) rulesList)))
    ((listp (nth 0 expression)) 
      (print "listp nth 0 expression")
      (cons (ddx (car expression) rulesList) (ddx (cdr expression) rulesList)))
    ((atom (nth 0 expression)) 
      (print "atom nth 0 Expression")
      (cons (ddx (cons (nth 0 expression) (ddx (cdr expression) rulesList)) rulesList)))
    (T (print 'GotDownHere))
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;
;Main Program
;;;;;;;;;;;;;;;;;;;;;;;;;



; test on this.
(setf expected '(plus (times 2 x) 3))
(setf input '(plus (power x 2) (times 3 x)))
(print 'input-)
(print input)
(print 'BeginningDDX)
(setf result (ddx input rulesList))
(print 'endDDX)
(print 'result-)
(print result)
(print 'expected-)
(print expected)
(print (tree-equal  expected result))


