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
  (if (eq b 'true)
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

(defun mal-list (&rest xs)
  (if xs xs 'empty))

(defun mal-listp (xs)
  (mal-boolean (or (listp xs) (eq xs 'empty))))

(defun mal-emptyp (xs)
  (mal-boolean (eq xs 'empty)))

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

;; namespace with functions

(defparameter *ns*
  '((+        . mal-add)
    (-        . mal-subtract)
    (*        . mal-multiply)
    (/        . mal-divide)
    (=        . mal-equal)
    (|prn|    . mal-pr)
    (|list|   . mal-list)
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
