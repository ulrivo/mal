(in-package :mal)

(defmacro when-not-bind (sym exp no-bind)
  "Let sym exp. If sym is not nil, answer sym, else no-bind"
  `(let ((,sym ,exp))
     (if ,sym ,sym ,no-bind)))

(defmacro let-if (sym exp then-exp else-exp)
  "Let sym exp. If sym is not nil, eval then-exp, else else-exp"
  `(let ((,sym ,exp))
     (if ,sym ,then-exp ,else-exp)))

(defun error-msg (msg)
  (format nil "error: ~a" msg))

(define-condition eval-error-condition (error)
  ((message :initarg :message :reader message)
   (ast :initarg :ast :reader ast))
  (:report (lambda (condition stream)
             (format stream "Eval error: ~a"
                     (message condition)))))

(defun signal-eval-error (message)
  (signal (make-condition 'eval-error-condition
                          :message message)))
