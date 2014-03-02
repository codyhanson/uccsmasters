;Demo program for the rules engine
;examples not specific to calculus.

;import the rules engine functions
(load "rules_engine.lisp")

;load the rules.
(setf ruleStrings (get-file "./testrules"))
(setf rulesList (process-list-of-strings ruleStrings))

;load the test cases.
(setf testPhrases (get-file "./testphrases"))
(setf testPhrasesList (process-list-of-strings testPhrases))

;;;;;;;;;;;;;;;;;;;;;;;;;
;Main Program
;;;;;;;;;;;;;;;;;;;;;;;;;


;Run the tests on each case in the input list
(loop for testCase in testPhrasesList do
  (print  "----------------------------------------------")
  (setf input (nth 0 testCase))
  (setf expectedResult (nth 1 testCase))
  ;compute the derivative
  (setf result (applyAllRules input rulesList))
  ;determine if it matches what we expected.
  (format t "~&input- ~A~&" input)
  (format t "result- ~A~&" result)
  (format t "expectedResult- ~A~&" expectedResult)
)
