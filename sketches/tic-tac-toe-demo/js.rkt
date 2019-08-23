#lang racket

(provide js
         (all-from-out urlang))

(require urlang)
(require syntax/parse/define
         (for-syntax racket))

(require racket/runtime-path)

(define-runtime-path here ".")


(begin-for-syntax
  (define (do-expand s)
    (define st (~a s))
    (define sts (string-split st "."))
    (cons s (map string->symbol sts)))

  (define (has-dots? s)
    (string-contains? (~a s) "."))

  (define (expand-dots s)
    (if (has-dots? s)
      (do-expand s)
      s)))


(define-syntax (js stx)
  (syntax-parse stx
    [(_ expr) 
     (define vars (flatten (map expand-dots (filter symbol? (flatten (syntax->datum #'expr))))))


     ;TODO: Lol, fix this.  Can we make urlang not produce a file at all?  
     (define rnd 
       (~a "module_" (random 10000)))


     #`(let ([ret
               (with-output-to-string
                 (thunk
                   (urlang
                     (urmodule temp 
                               (import #,@vars)
                               expr))))])


         ;TODO: Fix these hacks.  Why does urlang need to make a file anyway?  Can we just toggle that off? Open a github ticket...
         (current-urlang-output-file 
           (build-path here #,rnd))
         (current-urlang-exports-file 
           (build-path here #,(~a rnd ".exports")))
         (string-replace
           (string-replace (string-replace ret "\"use strict\";" "")
                           "\n" "")
           ";" "" ))
     ]))


(module+ test
  (require rackunit)
  (check-equal?
    "{x:2,y:(foo(10))}"
    (js (object [x 2]
                [y (foo 10)]
                )))
  
  (check-equal?
    "((ReactDOM.render)(((React[\"createElement\"])(\"div\",false,false))))"
    (js (ReactDOM.render (React.createElement "div" #f #f)))))

