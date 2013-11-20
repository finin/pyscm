;;; standard library for mcscheme/pscheme.  This will be automaticaly
;;; required when mcs starts.

;; aliases for the empty list
(define null (quote ()))
(define empty null)

;; common list access functions
(define first car)
(define caar (lambda (e) (car (car e))))
(define cadr (lambda (e) (car (cdr e))))
(define cddr (lambda (e) (cdr (cdr e))))
(define cdar (lambda (e) (cdr (car e))))
(define second cadr)
(define third (lambda (e) (car (cdr (cdr l)))))
(define rest cdr)

(define add1 (lambda (x) (+ x 1)))
(define sub1 (lambda (x) (- x 1)))

(define null? (lambda (x) (eq? x null)))

(define boolean? 
  ;; we don't have or :-(
  (lambda (x)
    (if (eq? x #t)
        #t
        (if (eq? x #f) #t #f))))

(define equal?
  ;; true iff two expressions e1 and e2 are the same structures
  (lambda (e1 e2)
    (if (pair? e1)
	(if (pair? e2)
	    (if (equal? (car e1) (car e2))
		(equal? (cdr e1) (cdr e2))
		#f)
	    #f)
	(eq? e1 e2))))

(define append 
  ;; this is just the two argument version
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (append (cdr l1) l2)))))

(define reverse 
  ;; returns the reverse of a list
  (lambda (l)
    (begin 
      ;; define a tail recursive 2-arg reverse
      (define reverse1 
        (lambda (l1 l2)
          (if (null? l1)
            l2
            (reverse1 (cdr l1) (cons (car l1) l2)))))
      ;; call it and return its value
      (reverse1 l null))))

(define length 
   ;; returns the length of a list
   (lambda (l) (if (null? l) 0 (+ 1 (length (cdr l))))))

(define last
  ;; returns the last element of a list
  (lambda (l)
    (if (null? l)
	(mcerror "last: expected a non-empty list, got ()" null)
	(if (null? (cdr l))
	    (car l)
	    (last (cdr l))))))

(define map
  (lambda (f l)
    (if (null? l)
        null
        (cons (f (car l)) (map f (cdr l))))))

