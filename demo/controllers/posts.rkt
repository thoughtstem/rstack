#lang racket

(require web-server/servlet
         web-server/servlet-env
         "../models/main.rkt")

(provide show-req index-req)

(define (layout elems)
  `(html (body ,@elems)))


(define (show i)
  ;Get the post with id = i

 (define p
   (find post% i))

  ;Create div for displaying text

  (list
  `(div (p ,(~a "You are looking at post " i)))

   ;Insert the div
  
  `(div (a ([href "/posts"]) "Back to posts"))))


(define (index)
  ;Get all posts
  (define ps (all post%))

  ;Create links
  (define ids (map get-id ps))
  (define links (map post-link ids))

  ;Create page with links
  (list
    `(div (p ,(~a "There are N posts: " (length ps))))

    `(div ,@links) ))


(define (post-link id)
  (define path (~a "/posts/" id))

  `(div (a ([href ,path]) 
           ,path)))

(define (show-req req i)
  (response/xexpr (layout (show i))))
   
(define (index-req req)
  (response/xexpr (layout (index))))
