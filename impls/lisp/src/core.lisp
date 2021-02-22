;;; core.lisp

(in-package :mal)

;; arithmetic functions

(defun mal-add (x y)
  (+ x y))

(defun mal-subtract (x y)
  (- x y))

(defun mal-multiply (x y)
  (* x y))

(defun mal-divide (x y)
  (truncate (/ x y)))

;; boolean functions

(defun mal-boolean (b)
  (if b 'true 'false))

(defun mal-not (b)
  (if (eql b 'true)
      'false
      'true))

(defun mal-equal (x y)
  (labels
      ((mequal (a b)
         (or
          (and (listp a)
               (listp b)
               (eql (length a) (length b))
               (every #'mequal a b))
          (equal a b))))
    (mal-boolean (mequal x y))))

(defun mal-listp (xs)
  (mal-boolean (listp xs)))

(defun mal-emptyp (xs)
  (mal-boolean (null xs)))

(defun mal-count (xs)
  (if (listp xs)
      (length xs)
      0))

;; comparisons

(defun mal-< (x y)
  (mal-boolean (< x y)))

(defun mal-<= (x y)
  (mal-boolean (<= x y)))

(defun mal-> (x y)
  (mal-boolean (> x y)))

(defun mal->= (x y)
  (mal-boolean (>= x y)))

;; print functions

(defun mal-pr (&rest ps)
  (format nil "~{~a~^ ~}" ps))

;; namespace with functions

(defparameter *ns*
  '((+        . mal-add)
    (-        . mal-subtract)
    (*        . mal-multiply)
    (/        . mal-divide)
    (=        . mal-equal)
    (|prn|    . mal-pr)
    (|list|   . list)
    (|list?|  . mal-listp)
    (|not|    . mal-not)
    (|empty?| . mal-emptyp)
    (|count|  . mal-count)
    (<        . mal-<)
    (<=       . mal-<=)
    (>        . mal->)
    (>=       . mal->=)
    (true     . true)
    (false    . false)
    (|nil|    . |nil|)))
