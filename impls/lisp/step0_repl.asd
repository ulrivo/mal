(defpackage #:mal-asd
  (:use :cl :asdf))

(ql:quickload :cl-readline :silent t)

(in-package :mal-asd)

(defsystem "step0_repl"
  :name "MAL"
  :version "1.0"
  :author "Ulrich Vollert"
  :description "Implementation of step 0 of MAL in Common Lisp"
  :serial t
  :components ((:file "step0_repl"))
  :depends-on (:cl-readline)
  :pathname "src/"
)
