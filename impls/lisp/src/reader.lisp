(in-package :mal)

(defmacro let-if (sym exp then-exp else-exp)
  "Let sym exp. If sym is not nil, eval then-exp, else else-exp"
  `(let ((,sym ,exp))
     (if ,sym ,then-exp ,else-exp)))

(defclass reader ()
  ((pos :initform 0
        :accessor pos)
   (tokens :initarg :tokens
           :accessor tokens)))

(defun make-reader (tks)
  (make-instance 'reader :tokens tks))

(defgeneric next (reader))
(defmethod next ((reader reader))
  (let ((po (pos reader)))
    (if (< po (length (tokens reader)))
        (progn
          (setf (pos reader) (1+ po))
          (nth po (tokens reader)))
        nil)))

(defgeneric at-end (reader))
(defmethod at-end (reader)
  (>= (pos reader) (length (tokens reader))))

(defgeneric peek (reader))
(defmethod peek ((reader reader))
  (if (at-end reader)
      nil
      (nth (pos reader) (tokens reader))))

(defparameter *mal-scanner* (cl-ppcre:create-scanner
                             "[\\s,]*(~@|[\\[\\]{}()'`~^@]|\"(?:\\\\.|[^\\\\\"])*\"?|;.*|[^\\s\\[\\]{}('\"`,;)]*)"))

(defun tokenize (string)
  (let (result)
    (cl-ppcre:do-scans (s e rs re *mal-scanner* string)
      (push (list (aref rs 0) (aref re 0)) result))
    (mapcar (lambda (l) (subseq string (first l) (second l)))
            (reverse (cdr result)))))

(defun error-msg (msg reader)
  (format t "error: ~a in tokens: ~a at token: ~a~%"
          msg (tokens reader) (pos reader)))

(defun mal-read-atom (reader)
  (let* ((atom (next reader))
         (i (parse-integer atom :junk-allowed t)))
    (if i i atom)))

(defun mal-read-list (reader)
  "Starting with a opening parentheis '('. Read a list of tokens as MAL forms."
  (next reader) ;; the opening parenthesis
  (do ((token (mal-read-form reader) (mal-read-form reader))
       (result nil (cons token result)))
      ((or (and (stringp token) (string= ")" token))
           (at-end reader))
       (if (and (stringp token) (string= ")" token))
           (reverse result)
           (error-msg "unbalanced parenthesis" reader)))))

(defun mal-read-form (reader)
  "Answer a MAL datatype"
  (if (string= "(" (peek reader))
      (mal-read-list reader)
      (mal-read-atom reader)))

(defun mal-read-str (string)
  "Read a string and answer a MAL type object."
  (let-if tok (tokenize string)
          (mal-read-form (make-reader (tokenize string)))
          nil))

(defun mal-print-str (mal)
  "Read a MAL type object and answer a string."
  (cond
    ((numberp mal) (format nil "~a" mal))
    ((listp mal) (format nil "(~{~a~^ ~})" (mapcar #'mal-print-str mal)))
    (t (format nil "~a" mal))))
