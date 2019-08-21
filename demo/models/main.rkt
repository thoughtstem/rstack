#lang racket

(provide 
  (all-from-out "./schema.rkt") 
  (all-from-out "../lib/db.rkt") 

  #;
  (all-from-out "./comments-model.rkt") 
  (all-from-out "./posts-model.rkt"))

(require 
  "./schema.rkt" 
  "../lib/db.rkt" 


  #;
  "./comments-model.rkt"
  "./posts-model.rkt")

#;
(find comment% 1)
#;
(find post% 1)
