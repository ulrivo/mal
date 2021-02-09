(in-package :mal)

(defun init-env ()
  "Initialize a new environment with all functions from *ns*
   defined in core.lisp. Answer environment."
  (let ((env (make-environment)))
    (mapcan (lambda (kv) (env-set env (car kv) (cdr kv))) *ns*)
    env))

(defparameter *env* (init-env))

(defun mal-eval (ast env)
  (cond
    ((not (listp ast)) (mal-eval-ast ast env))
    ((null ast) ast)
    ((listp ast)
     (case (first ast)
       (|def!|
        (env-set env (second ast) (mal-eval (third ast) env)))
       (|let*|      ;; build new env with binding all elements of second list
        (let ((new-env (make-environment env)))
          (loop for (x y) on (second ast) by #'cddr do
            (if y
                (env-set new-env x (mal-eval y new-env))
                (signal-eval-error
                 (format nil "odd number of arguments in let*: ~s" ast))))
          (mal-eval (third ast) new-env)))
       (|do|     ;; do evaluate all elements of a list, answer last
        (last (mal-eval-ast (cdr ast) env)))
       (|if|
        (mal-eval (if (eq (mal-eval (second ast) env) 'true)
                      (third ast)
                      (fourth ast)) env))
       (|fn*|
        (lambda (&rest params)
          (mal-eval (third ast)
                    (make-environment env (second ast)  params))))
       (otherwise
        (let ((fargs (mal-eval-ast ast env)))
          (apply (car fargs) (cdr fargs))))))))

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
    (princ (mal-print-str result)))
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
