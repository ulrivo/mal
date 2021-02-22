(in-package :mal)

(defun mal-print-str (mal)
  "Read a MAL type object and answer a string."
  (cond
    ((numberp mal) (format t "~a~%" mal))
    ((listp mal) (format t "(~{~a~^ ~})~%" (mapcar #'mal-print-str mal)))
    ((functionp mal) (format t "#<function>~%"))
    ((eq mal 'true) (format t "true~%"))
    ((eq mal 'false) (format t "false~%"))
    (t (format t "~a~%" mal))))
