(defpackage #:mal-asd
  (:use :cl :asdf))

(ql:quickload :cl-ppcre :silent t)
(ql:quickload :cl-readline :silent t)

(in-package :mal-asd)

(defsystem "step2_eval"
  :name "MAL"
  :version "1.0"
  :author "Ulrich Vollert"
  :description "Implementation of step 2 of MAL in Common Lisp"
  :components ((:file "package")
               (:file "reader" :depends-on ("package"))
               (:file "printer" :depends-on ("package"))
               (:file "step2_eval"
                :depends-on ("package" "reader" "printer")))
  :depends-on (:cl-readline :cl-ppcre)
  :pathname "src/"
)
