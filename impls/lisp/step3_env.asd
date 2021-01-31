(defpackage #:mal-asd
  (:use :cl :asdf))

;; (ql:quickload :cl-ppcre :silent t)
;; (ql:quickload :cl-readline :silent t)

(in-package :mal-asd)

(defsystem "step3_env"
  :name "MAL"
  :version "1.0"
  :author "Ulrich Vollert"
  :description "Implementation of step 3 of MAL in Common Lisp"
  :components ((:file "package")
               (:file "util" :depends-on ("package"))
               (:file "env" :depends-on ("package" "util"))
               (:file "reader" :depends-on ("package" "util"))
               (:file "printer" :depends-on ("package"))
               (:file "step3_env"
                :depends-on ("package" "util" "reader" "printer" "env")))
  :depends-on (:cl-readline :cl-ppcre)
  :pathname "src/"
)
