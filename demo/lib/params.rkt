#lang racket

(provide params)

(require web-server/servlet 
         "./resource-dispatcher.rkt")

(define (params id)
  (spin:params (current-req) id))

;NOTE: I "borrowed" this from the spin project
(define (spin:params request key)
  (define query-pairs (url-query (request-uri request)))
  (define body-pairs
    (match (request-post-data/raw request)
      [#f empty]
      [body (url-query (string->url (string-append "?"  (bytes->string/utf-8 body))))]))
  #;
  (define url-pairs
    (let ([keys (cadr (request->handler/keys/response-maker request))])
      (request->key-bindings request keys)))
  (hash-ref (make-hash (append query-pairs body-pairs 
                               #;
                               url-pairs)) key ""))


