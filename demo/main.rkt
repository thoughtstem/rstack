#lang racket
(require web-server/servlet
         web-server/servlet-env)

(require (prefix-in posts: "./controllers/posts.rkt"))

(define-values (my-dispatch my-url)
 (dispatch-rules
  [("") home]  ; Respond to /
  [("posts") posts:index-req] ; Respond to /posts
  [("posts" (integer-arg)) posts:show-req] ; Respond to /posts/:id
  [else not-found]))

(define (my-app req)
  (my-dispatch req))

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
