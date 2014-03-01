; Symbolic Differentiation, using rules_engine.lisp
; Cody Hanson
; Spring 2014 - CS5860-AI UCCS

;import the rules engine functions
(load "rules_engine.lisp")

;load the rules.
(setf ruleStrings (get-file "./derivativerules"))
(setf rulesList (process-list-of-strings ruleStrings))

;load the test cases.
(setf testDerivatives (get-file "./derivativeTestInput"))
(setf testDerivativesList (process-list-of-strings testDerivatives))

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
        (applyOneRule (cons (nth 0 expression) (ddx (cdr expression) rulesList)) rulesList))
    (T (print 'GotDownHere))
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;
;Main Program
;;;;;;;;;;;;;;;;;;;;;;;;;

(setf resultsList (list))

;Run the tests on each case in the input list
(loop for testCase in testDerivativesList do
  (print  "----------------------------------------------")
  (setf input (nth 0 testCase))
  (setf expectedResult (nth 1 testCase))
  ;compute the derivative
  (setf result (ddx input rulesList))
  ;determine if it matches what we expected.
  (setf matched (tree-equal  expectedResult result))
  (format t "input- ~A~&" input)
  (format t "result- ~A~&" result)
  (format t "expectedResult- ~A~&" expectedResult)
  (format t "Match?: ~A~&" matched)
  (setf resultsList (append resultsList (list matched)))
)

(format t "~&Finished. Results Array: ~A~&" resultsList)
