(in-package :mal)

(defun main ()
  (do ((i 0 (1+ i))
       (text ""))
      ((null text))
    (setf text
          (rl:readline :prompt (format nil "user> ")
                       :add-history t))
    (when text
      (princ (mal-print-str (mal-read-str text))))
    (terpri)))
