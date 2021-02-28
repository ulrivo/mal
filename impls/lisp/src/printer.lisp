(in-package :mal)

;; print functions

(defun mal-pr (&rest ps)
  (format nil "~{~a~^ ~}" ps))

(defun mal-print-str (mal)
  "Read a MAL type object and print a string."
  (cond
    ((numberp mal) (format t "~a~%" mal))
    ((null mal) (format t "nil~%"))
    ((eq mal 'empty)(format t "()~%"))
    ((listp mal) (format t "(~{~a~^ ~})~%" mal))
    ((functionp mal) (format t "#<function>~%"))
    ((eq mal 'true) (format t "true~%"))
    ((eq mal 'false) (format t "false~%"))
    (t (format t "~a~%" mal))))
