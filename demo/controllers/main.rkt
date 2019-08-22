#lang racket

(provide dispatcher)

(require racket/runtime-path
         "../lib/resource-dispatcher.rkt")

(define-runtime-path here ".")

(define (dispatcher #:fallback fallback)
  ;TODO: Auto chain them based on files in folder
  (define users
    (auto-load-dispatcher here "users" fallback))

  (define comments 
    (auto-load-dispatcher here "comments" users)) 

  (auto-load-dispatcher here "posts" comments))
