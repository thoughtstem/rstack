#lang racket

(provide 
  get
  (except-out
    (all-from-out racket)
    #%module-begin)

  (rename-out 
    [my-#%module-begin
      #%module-begin]))

(define-syntax-rule (get user-path response)
  ;Doing it as a function is gross, don't want to call ones that may have side effects.
  (lambda (method path)
    (displayln method)
    (displayln path)
    (displayln user-path)
    (if (and (string=? "GET" method)
             (string=? user-path path))
      response
      #f)))

(define-syntax-rule (my-#%module-begin expr ...)
  (#%module-begin
   (require web-server/servlet
            web-server/servlet-env)

   
   (define (method+path->response method path)
     (define responders (list expr ...))

     (define resp 
       (findf (lambda (f)
                (f (~a method) path)) 
              responders))

     ;Yuck. Calling it twice
     

     (response/xexpr
       `(html
          (body
            ,(resp (~a method) path))))

     )

   (define (start req)
     (define path-parts 
       (map path/param-path (url-path (request-uri req))))

     (define path-string
       (string-join path-parts "/"))

     (define method (request-method req))

     (method+path->response method
                            path-string) )

   (serve/servlet start
                  #:servlet-regexp #rx""
                  )))



