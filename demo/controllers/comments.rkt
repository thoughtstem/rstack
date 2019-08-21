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
  `((div "index")))


(define (update i)
  `((div "update")))


(define (make)
  `((div "make")))

(define (edit i)
  `((div "edit")))


(define (create)
  `((div "create")) )

