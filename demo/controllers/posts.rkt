#lang racket

(require web-server/servlet
         web-server/servlet-env
         "../models/main.rkt")

(provide 
  current-req

  make-req
  edit-req
  update-req
  create-req
  show-req delete-req 
  index-req)

(define (layout elems)
  `(html (body ,@elems)))


(define (make)
  (list
    `(h1 "Create")
    `(div "Let's make a post!")))

(define (delete i)
 (define p
   (find post% i))

  ;Makes it really delete
 
  (destroy p)

  (list
    `(div "Post deleted!")
    `(div (a ([href "/posts"]) "Back to posts"))))

(define (show i)
  ;Get the post with id = i

 (define p
   (find post% i))

 (define t
   (send p get-text))
 
 ;Create div for displaying text

  (list
    `(h1 ,(~a "Post " i))

    `(div ,t)

    `(div 
       (a ([href ,(~a "/posts/" i "/edit")]) "Edit"))  

    (delete-button i)

    `(br)
    `(br)
    `(br)

    `(div (a ([href "/posts"]) "Back to posts"))
    
    ))


(define (delete-button i)
  ;TODO: Clean this up. It's a mess.
  (define delete-js
    (~a
      "const Http = new XMLHttpRequest(); const url=\"/posts/"
      i
      "\"; Http.open(\"DELETE\", url); Http.onload=function(){window.location=\"/posts\";}; Http.send(); "))

 `(button ([onClick ,delete-js])
     "Delete"))


(define (index)

  ;Get all posts
  (define ps (all post%))

  ;Create links
  (define ids (map get-id ps))
  (define links (map post-link ids))

  ;Create page with links
  (list
    `(div (p ,(~a "There are " (length ps) " posts")))

    `(div ,@links) 

    `(br)
    `(br)
    `(br)
    
    `(a ([href "/posts/make"]) "New Post")))


(define (post-link id)
  (define path (~a "/posts/" id))

  `(div (a ([href ,path]) 
           ,path)))


(define (update i)
  (list
    `(div "update stub")))

(define (edit i)
  (list
    `(h1 "Edit")))

(define (create)
  (define p (new post%
                 [text (params 'text)]))

  (save p)

  `(div "Created post"))

(define current-req (make-parameter #f))

(define (params id)
  (spin:params (current-req) id))

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

(define (update-req req i)
  (parameterize
    ([current-req req])
    (response/xexpr (layout (update i)))))

(define (create-req req)
  (parameterize
    ([current-req req])
    (response/xexpr (layout (create)))))

(define (delete-req req i)
  (parameterize
    ([current-req req])
    (response/xexpr (layout (delete i)))))

(define (show-req req i)
  (parameterize
    ([current-req req])
    (response/xexpr (layout (show i)))))
   
(define (index-req req)
  (parameterize
    ([current-req req])
    (response/xexpr (layout (index)))))


(define (make-req req)
  (parameterize
    ([current-req req])
    (response/xexpr (layout (make)))))



(define (edit-req req i)
  (parameterize
    ([current-req req])
    (response/xexpr (layout (edit i)))))




