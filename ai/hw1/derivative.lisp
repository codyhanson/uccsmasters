; Symbolic Differentiation, using rules_engine.lisp
; Cody Hanson
; Spring 2014 - CS5860-AI UCCS

;import the rules engine functions
(load "rules_engine.lisp")
(print "Rules Engine Loaded")

;load the rules.
(setf ruleStrings (get-file "./derivativerules"))
(setf rulesList (process-list-of-strings ruleStrings))

(print "Rules List Loaded")

;load the test cases.
(setf testDerivatives (get-file "./derivativeTestInput"))
(setf testDerivativesList (process-list-of-strings testDerivatives))

(print "Test case List Loaded")

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
  ;(format t "expression: ~S~%" expression)
  (cond
    ;the order of rules is important.
    ((null expression) NIL)
    ((atom (nth 0 expression)) 
        (embeddedDdx (applyOneRule expression rulesList) rulesList))
    (T (print 'GotDownHere))
    )
  )

;given an expression which has been differentiated once already,
;search for embedded (DDX ) froms, that require further derivations, and apply the ddx function.
(defun embeddedDdx (expression rulesList)
  ;(print "embeddedDdx")
  ;(print expression)
    (cond
      ((null expression) NIL)
      ((atom expression) expression) ;nothing to do!
      ((and (atom (nth 0 expression)) (eq 'DDX (nth 0 expression))) ;found an embedded ddx 
       (ddx (car (cdr expression)) rulesList))
      ((atom (nth 0 expression)) 
        (cons (car expression) (embeddedDdx (cdr expression) rulesList)) 
      )
      ((listp  (nth 0 expression))
        (cons (embeddedDdx (car expression) rulesList) (embeddedDdx (cdr expression) rulesList))
      )
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
  (format t "~&input- ~A~&" input)
  (format t "result- ~A~&" result)
  (format t "expectedResult- ~A~&" expectedResult)
  (format t "Match?: ~A~&" matched)
  (setf resultsList (append resultsList (list matched)))
)

(format t "~&Finished. Results Array: ~A~&" resultsList)

