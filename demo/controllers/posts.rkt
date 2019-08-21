#lang racket

(require web-server/servlet
         web-server/servlet-env
         "../lib/resource-dispatcher.rkt" 
         "../models/main.rkt")

(provide 
  make
  edit
  update
  create
  show
  delete
  index)



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
  (define links (map post-link ps))

  ;Create page with links
  (list
    `(div (p ,(~a "There are " (length ps) " posts")))

    `(div ,@links) 

    `(br)
    `(br)
    `(br)
    
    `(a ([href "/posts/make"]) "New Post")))


(define (post-link p)
  (define path (~a "/posts/" (get-id p)))

  `(div (a ([href ,path]) 
           ,(send p get-text))))


(define (update i)
  (define p (find post% i))
  (send p set-text (params 'text))
  (save p)

  (show i))


(define (make)
  (edit-form))

(define (edit i)
  (edit-form i))

(define (edit-form (i #f))
  (list
    `(h1 ,(if i "Edit" "Create"))
    `(form ([action ,(if i
                       (~a "/posts/" i)
                       "/posts")]
            [method "post"])
       "Text:" 
       (br)
       (input ([type "text"] [name "text"])) 
       (input ([type "submit"] [value "Submit"])))))

(define (create)
  (define p (new post%
                 [text (params 'text)]))

  (save p)

  ;I wish this worked.  Can't get the id
  ;  from racquel.  Opened ticket:
  ;  https://github.com/brown131/racquel/issues/11

  #;
  (show (get-id p))

  ;Just load the index for now...
  
  (index))


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



