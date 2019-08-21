#lang racket
(require web-server/servlet
         web-server/servlet-env)

(require "./controllers/main.rkt")

(define-values (default-dispatcher default-url)
  (dispatch-rules 
    [("") home]
    [else not-found]))

(define (my-app req)
  (define d (dispatcher 
              #:fallback 
              default-dispatcher))
  (d req))

(define (home req)
  (response/xexpr
   `(html (body (p "Home")
       (a ([href "/posts"]) 
        "/posts")))))

(define (not-found req)
  (response/xexpr
   `(html (body (p "Not found")))))

(serve/servlet my-app
               #:servlet-path "/"
               #:servlet-regexp #rx""
               #:listen-ip #f)
