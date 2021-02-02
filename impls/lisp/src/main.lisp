(in-package :mal)

(defun mal-add (x y)
  (+ x y))

(defun mal-subtract (x y)
  (- x y))

(defun mal-multiply (x y)
  (* x y))

(defun mal-divide (x y)
  (truncate (/ x y)))


(defun init-env ()
  "Initialize a new environment with arithmetic functions. Answer environment."
  (let ((env (make-instance 'environment)))
    (mapcan (lambda (kv) (env-set env (car kv) (cdr kv)))
            '((+ . mal-add)
              (- . mal-subtract)
              (* . mal-multiply)
              (/ . mal-divide)))
    env))

(defparameter *env* (init-env))

(defun mal-eval (ast env)
  (cond
    ((not (listp ast)) (mal-eval-ast ast env))
    ((null ast) ast)
    ((listp ast)
     (cond
       ((eql (first ast) (intern "def!" :mal))
        (env-set env (second ast) (mal-eval (third ast) env)))
       ((eql (first ast) (intern "let*" :mal))
        (let ((new-env (make-instance 'environment :outer env)))
          (loop for (x y) on (second ast) by #'cddr do
            (when y (env-set new-env x (mal-eval y new-env))))
          (mal-eval (third ast) new-env)))
       (t (let ((fargs (mal-eval-ast ast env)))
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
