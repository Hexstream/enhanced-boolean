(in-package #:enhanced-boolean)

(declaim (inline boolean) (ftype (function (t) cl:boolean) boolean))

(defun boolean (generalized-boolean)
  (if generalized-boolean t nil))

(define-compiler-macro boolean (generalized-boolean)
  `(if ,generalized-boolean t nil))

(deftype boolean ()
  'cl:boolean)
