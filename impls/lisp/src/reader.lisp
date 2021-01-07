(in-package :mal)

(defclass reader ()
  ((pos :initform 0
        :accessor pos)
   (tokens :initarg :tokens
           :accessor tokens)))


(defun make-reader (tks)
  (make-instance 'reader :tokens tks))

(defgeneric next (reade))

(defmethod next ((reade reader))
  (let ((po (pos reade)))
    (if (< po (length (tokens reade)))
        (progn
          (setf (pos reade) (1+ po))
          (nth po (tokens reade)))
        nil)))


(defgeneric peek (reade))

(defmethod peek ((reade reader))
  (if (< (pos reade) (length (tokens reade)))
      (nth (pos reade) (tokens reade))
      nil))

(defparameter *mal-scanner* (cl-ppcre:create-scanner
 "[\\s,]*(~@|[\\[\\]{}()'`~^@]|\"(?:\\\\.|[^\\\\\"])*\"?|;.*|[^\\s\\[\\]{}('\"`,;)]*)"))

(defun tokenize (string)
  (let (result)
    (cl-ppcre:do-scans (s e rs re *mal-scanner* string)
      (push (list (aref rs 0) (aref re 0)) result))
    (mapcar (lambda (l) (subseq string (first l) (second l)))
            (reverse (cdr result)))))

(defun read-str (string)
  ;; missing read-form
  (read-form (make-reader (tokenize string))))
