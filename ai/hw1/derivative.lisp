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
  (cond 
    ((atom aList) NIL)
    ((endp aList) T)
    ((atom (car aList)) (flat-list (cdr aList))) 
    ((listp (car aList)) NIL)
   )
)

;Define our derivative function.
(defun ddx (expression rulesList)
  (cond
    ((listp (car expression)) 
      (cons (ddx (car expression) rulesList) (ddx (cdr expression) rulesList)))
    ((flat-list expression)
      (applyAllRules expression rulesList))
    ((flat-list (car expression))
      (cons (applyAllRules (car expression) rulesList)) (ddx (cdr expression) rulesList))
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;
;Main Program
;;;;;;;;;;;;;;;;;;;;;;;;;



; test on this.
(setf expected '(plus (times 2 x) 3))
(setf result (ddx '(plus (power x 2) (times 3 x))))
(print result)
(print expected)
(print (tree-equal  expected result))
