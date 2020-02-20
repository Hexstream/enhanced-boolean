(cl:defpackage #:enhanced-boolean_tests
  (:use #:cl #:parachute)
  (:shadow #:test)
  (:shadowing-import-from #:enhanced-boolean #:boolean))

(cl:in-package #:enhanced-boolean_tests)

(defun %compile-cleanly (code)
  (multiple-value-bind (function warnp failp) (compile nil code)
    (is eq warnp nil)
    (is eq failp nil)
    function))

(defmacro %compile (code)
  `(%compile-cleanly ',code))

(defmacro test (comp expected form)
  `(progn
     (is ,comp ,expected ,form)
     (locally (declare (inline boolean))
       (is ,comp ,expected ,form))
     (locally (declare (notinline boolean))
       (is ,comp ,expected ,form))))

(define-test "main"
  (test eq t (boolean t))
  (test eq nil (boolean nil))
  (let ((trues '(t true false 0 #() "" #\0)))
    (dolist (true trues)
      (test eq t (boolean true)))
    (test equal (make-list (length trues) :initial-element t)
          (mapcar #'boolean trues)))
  (test equal '(t nil) (mapcar (%compile (lambda (boolean)
                                           (check-type boolean boolean)
                                           boolean))
                               '(t nil)))
  (test equal '(t nil) (mapcar (%compile (lambda (boolean)
                                           (declare (type boolean boolean))
                                           boolean))
                               '(t nil))))
