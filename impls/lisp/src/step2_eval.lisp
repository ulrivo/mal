(in-package :mal)

(defun mal-add (x y)
  (+ x y))

(defun mal-subtract (x y)
  (- x y))

(defun mal-multiply (x y)
  (* x y))

(defun mal-divide (x y)
  (truncate (/ x y)))

(defparameter *env*
  '((+ . mal-add)
    (- . mal-subtract)
    (* . mal-multiply)
    (/ . mal-divide)))

(defun mal-eval (ast env)
  (cond
    ((not (listp ast)) (mal-eval-ast ast env))
    ((null ast) ast)
    ((listp ast)
     (let ((fargs (mal-eval-ast ast env)))
       (apply (car fargs) (cdr fargs))))))

(defun mal-eval-ast (ast env)
  (cond
    ((symbolp ast)
     (let ((result (cdr (assoc ast env))))
       (if result
           result
           (signal (make-condition 'eval-error-condition
                                   :ast ast
                                   :message
                                   (format nil "'~a' not found" ast))))))
    ((listp ast)
     (mapcar (lambda (a) (mal-eval a env)) ast))
    (t ast)))

(defun repl (string)
  "Read, eval, and print the result of evaluation of an input string."
  (let ((result (handler-case
                    (mal-eval (mal-read-str string) *env*)
                  (eval-error-condition (err)
                    (error-msg (message err)))
                  (sb-int:simple-program-error (err)
                    (error-msg err)))))
    (princ (mal-print-str result)))
  (terpri))

(defun main ()
  (do ((i 0 (1+ i))
       (text ""))
      ((null text))
    (setf text
          (rl:readline :prompt (format nil "user> ")
                       :add-history t))
    (when text
      (repl text))))
