(in-package :mal)

(defparameter *nil* (intern "nil" :mal))

(defun init-env ()
  "Initialize a new environment with all functions from *ns*
   defined in core.lisp. Answer environment."
  (let ((env (make-environment)))
    (mapcan (lambda (kv) (env-set env (car kv) (cdr kv))) *ns*)
    env))

(defparameter *env* (init-env))

(defun mal-eval (ast env)
  "Evaluate a MAL expression."
  (loop
    (cond
      ((not (listp ast)) (return (mal-eval-ast ast env)))
      ((null ast) (return ast))
      ((listp ast)
       (case (first ast)
         (|def!|
          (return (env-set env (second ast) (mal-eval (third ast) env))))
         (|let*| ;; build new env with binding all elements of second list
          (let ((new-env (make-environment env)))
            (loop for (x y) on (second ast) by #'cddr do
              (if y
                  (env-set new-env x (mal-eval y new-env))
                  (signal-eval-error
                   (format nil "odd number of arguments in let*: ~s" ast))))
            (setf ast (third ast) env new-env))) ;; setf ast+env and loop
         (|do| ;; do evaluate all but the last elements of a list, loop with last
          (progn
            (mal-eval-ast (butlast (cdr ast)) env)
            (setf ast (car (last ast)))))
         (|if|                          ;; loop with true or false expresssion as ast
          (let ((result (mal-eval (second ast) env)))
            (setf ast (if (not (or (eq result 'false)
                                   (eq result *nil*)))
                          (third ast)
                          (if (< (length ast) 4) *nil* (fourth ast))))))
         (|fn*|
          (return
            (make-function (third ast) (second ast) env
                           (lambda (&rest params)
                             (mal-eval (third ast)
                                       (make-environment env (second ast) params))))))
         (|prn|
          (return (mal-print-str (mal-eval-ast (second ast) env))))
         (otherwise
          (let* ((fargs (mal-eval-ast ast env))
                 (f (car fargs))
                 (args (cdr fargs)))
            (if (mal-function-p f)
                (setf ast (ast f) env (make-environment (env f) (params f) args))
                (return (apply f args))))))))))

(defun mal-eval-ast (ast env)
  (cond
    ((symbolp ast) (env-find env ast))
    ((listp ast)   (mapcar (lambda (a) (mal-eval a env)) ast))
    (t             ast)))

(defun repl (string)
  "Read, eval, and print the result of evaluation of an input string."
  (let ((result (handler-case
                    (mal-eval (mal-read-str string) *env*)
                  (eval-error-condition (err)
                    (error-msg (message err)))
                  (sb-int:simple-program-error (err)
                    (error-msg err))
                  (t (err)
                    (error-msg (format nil " -default- ~a" err))))))
    (mal-print-str  result))
  (terpri))

(defun main ()
  (setf *env* (init-env))
  (do ((i 0 (1+ i))
       (text ""))
      ((null text))
    (setf text
          (rl:readline :prompt (format nil "user> ")
                       :add-history t))
    (when text
      (repl text))))
