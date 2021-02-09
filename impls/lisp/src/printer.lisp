(in-package :mal)

(defun mal-print-str (mal)
  "Read a MAL type object and answer a string."
  (cond
    ((numberp mal) (format nil "~a" mal))
    ((listp mal) (format nil "(~{~a~^ ~})" (mapcar #'mal-print-str mal)))
    ((functionp mal) (format nil "#<function>"))
    ((eq mal 'true) "true")
    ((eq mal 'false) "false")
    (t (format nil "~a" mal))))
