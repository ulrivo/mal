(defpackage #:mal-asd
  (:use :cl :asdf))

(ql:quickload :cl-ppcre :silent t)
(ql:quickload :cl-readline :silent t)

(in-package :mal-asd)

(defsystem "step1_read_print"
  :name "MAL"
  :version "1.0"
  :author "Ulrich Vollert"
  :description "Implementation of step 1 of MAL in Common Lisp"
  :serial t
  :components ((:file "reader")
               (:file "step1_read_print"))
  :depends-on (:cl-readline :cl-ppcre)
  :pathname "src/"
)
