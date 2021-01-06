(in-package :mal)

(defclass reader ()
  ((pos :initform 0
        :accessor pos)
   (tokens :initarg :tokens
           :accessor tokens)))


(defun make-reader (string)
  (make-instance 'reader
                 :tokens (str:words string)))


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

(defun tokenize (string)
  (cl-ppcre:all-matches-as-strings 
   "[\\s,]*(~@|[\\[\\]{}()'`~^@]|\"(?:\\\\.|[^\\\\\"])*\"?|;.*|[^\\s\\[\\]{}('\"`,;)]*)"
   string))
