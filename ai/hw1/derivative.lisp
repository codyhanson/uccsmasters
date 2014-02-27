; Symbolic Differentiation, using rules_engine.lisp
; Cody Hanson
; Spring 2014 - CS5860-AI UCCS

;import the rules engine functions
(load "rules_engine.lisp")

;load the rules.
(setf ruleStrings (get-file "./derivativerules"))
(setf rulesList (process-list-of-strings ruleStrings))
(print rulesList)

;Define our derivative function.
(defun ddx (expression)
  ;(applyRule 
  (list 'a)
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
