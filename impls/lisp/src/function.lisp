(in-package :mal)

(defclass mal-function  ()
  ((ast    :initarg :ast    :reader ast)
   (params :initarg :params :reader params)
   (env    :initarg :env    :reader env)
   (fn     :initarg :fn     :reader fn)))

(defun make-function (ast params env fn)
  (make-instance 'mal-function :ast ast :params params :env env :fn fn))

(defun mal-function-p (f)
  (eq (class-of  f) (find-class 'mal-function)))
