(defpackage #:mal-asd
  (:use :cl :asdf))

(in-package :mal-asd)

(defsystem "step4_if_fn_do"
  :name "MAL"
  :version "1.0"
  :author "Ulrich Vollert"
  :description "Implementation of step 4 of MAL in Common Lisp"
  :components ((:file "package")
               (:file "util" :depends-on ("package"))
               (:file "core" :depends-on ("package"))
               (:file "env" :depends-on ("package" "util"))
               (:file "reader" :depends-on ("package" "util"))
               (:file "printer" :depends-on ("package"))
               (:file "main"
                :depends-on ("package" "util" "core" "reader" "printer" "env")))
  :depends-on (:cl-readline :cl-ppcre)
  :pathname "src/"
)
