(asdf:defsystem #:enhanced-boolean_tests

  :author "Jean-Philippe Paradis <hexstream@hexstreamsoft.com>"

  ;; See the UNLICENSE file for details.
  :license "Public Domain"

  :description "enhanced-boolean unit tests."

  :depends-on ("enhanced-boolean"
               "parachute")

  :serial cl:t
  :components ((:file "tests"))

  :perform (asdf:test-op (op c) (uiop:symbol-call '#:parachute '#:test '#:enhanced-boolean_tests)))
