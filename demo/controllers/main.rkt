#lang racket

(provide dispatcher)

(require racket/runtime-path
         "../lib/resource-dispatcher.rkt")

(define-runtime-path here ".")

(define (dispatcher #:fallback fallback)
  ;TODO: Auto chain them based on files in folder
  (define comments (auto-load-dispatcher here "comments" fallback)) 
  (auto-load-dispatcher here "posts" 
                        comments))
