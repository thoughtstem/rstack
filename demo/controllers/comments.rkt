#lang racket

(require web-server/servlet
         web-server/servlet-env
         "../lib/scaffold.rkt"  
         "../lib/resource-dispatcher.rkt" 
         "../models/main.rkt" )

(provide 
  make
  edit
  update
  create
  show
  delete
  index)



(define (delete i)
  `((div "delete")))

(define (show i)
  (scaffold-show comment% i))

(define (index)
  (scaffold-index comment%))

(define (update i)
  (scaffold-update comment% i))

(define (make)
  (scaffold-make comment%))

(define (edit i)
  (scaffold-edit comment% i))


(define (create)
  `((div "create")) )

