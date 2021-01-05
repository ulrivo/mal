(defpackage :mal
  (:use :common-lisp)
  (:import-from :uiop
   :getenv)
  (:import-from :cl-readline
   :readline)
  (:export :main))

(in-package :mal)

(defun main ()
  (princ "hello welt, lieber Ulrich"))
