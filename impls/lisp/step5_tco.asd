(defpackage #:mal-asd
  (:use :cl :asdf))

(in-package :mal-asd)

(defsystem "step5_tco"
  :name "MAL"
  :version "1.0"
  :author "Ulrich Vollert"
  :description "Implementation of step 5 of MAL in Common Lisp"
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
