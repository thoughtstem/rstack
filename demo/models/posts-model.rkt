#lang racket

(provide post%)

(require racquel
         db
         "schema.rkt")

(define post%
  (data-class object%
    (table-name "posts")

    (column (id   #f ;default val
                  "id"))
    (init-column
      (text #f "text"))  

    (primary-key id)


    (define/public (name)
     "Cool post")

    (define/public (get-text)
         (get-column text this))
    (super-new)))

;Examples:

#;
(define p
  (new post% 
       [text "Second post!"]))

#;
(save p)


