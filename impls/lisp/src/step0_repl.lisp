;;;  (load "step0_repl.asd")
;;;  Omit the load if there is a link:
;;;   ln -s ~/dev/lisp/mal/impls/lisp ~/common-lisp/mal

;;;  (ql:quickload :step0_repl)

;;;   ,in-package :mal

(defpackage :mal
  (:use :common-lisp)
  (:import-from :cl-readline
   :readline)
  (:export :main))

(in-package :mal)

(defun repl (input)
  input)

;; (defun main ()
;;   (loop
;;     (princ "user> ")
;;     (force-output)
;;     (princ (repl (read-line)))
;;     (terpri)))

(defun main ()
  (do ((i 0 (1+ i))
       (text ""))
      ((null text))
    (setf text
          (rl:readline :prompt (format nil "user> ")
                       :add-history t))
    (princ text)
    (terpri)))
