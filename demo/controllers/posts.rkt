#lang racket

(require web-server/servlet web-server/servlet-env
         "../lib/scaffold.rkt" 
         "../lib/resource-dispatcher.rkt" 
         "../lib/params.rkt" 
         "../models/main.rkt")

(provide 
  make
  edit
  update
  create
  show
  delete
  index)


;TODO: Can auto-generate this probably
(define (delete i)
  (scaffold-delete post% i))

(define (show i)
  (scaffold-show post% i))

(define (index)
  (scaffold-index post%))


(define (update i)
  (scaffold-update post% i))

(define (make)
  (scaffold-make post%))

(define (edit i)
  (scaffold-edit post% i))


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

