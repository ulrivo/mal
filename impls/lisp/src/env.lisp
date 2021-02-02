(in-package :mal)

(defclass environment ()
  ((env-hash :initform (make-hash-table) :reader env-hash)
   (outer :initarg :outer :initform nil :reader outer)))

(defgeneric env-set (env key value)
  (:documentation "Add a key and a value to hash and answer env"))

(defmethod env-set ((env environment) (key symbol) value)
  (setf (gethash key (env-hash env)) value))

(defgeneric env-find (env key)
  (:documentation "Find the value for the key. If it is not present and
                   outer is not nil, find recursively in environment outer"))

(defmethod env-find ((env environment) (key symbol))
  (multiple-value-bind (value flag)
      (gethash key (env-hash env))
    (if flag
        value
        (if (outer env)
            (env-find (outer env) key)
            (signal-eval-error (format nil "value for '~a' not found." key))))))
