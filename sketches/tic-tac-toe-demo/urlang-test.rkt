#lang racket

(require syntax/parse/define)

(define-syntax (lit stx)
  (syntax-parse stx
    #:datum-literals (unquote)
    [(_ (unquote thing))  #'thing]
    [(_ thing)               #'`thing]))

    
(define-syntax (js stx)
  (syntax-parse stx
    #:datum-literals (unquote)
    [(_ (unquote expr))
     #'expr
    ]
    [(_ expr) 
     #''(this is js: expr)]))


(js
  ,(lit 
     (my (thing ,(+ 2 2)))))



