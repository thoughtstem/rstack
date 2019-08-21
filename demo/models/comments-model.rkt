#lang racket

#;
(provide comment%)

(require racquel
         db
         "schema.rkt")

(define comment%
  (data-class object%
    (table-name "comments")

    (column (id   #f ;default val
                  "id"))
    (init-column
      (text #f "text"))  

    (primary-key id)

    (define/public (set-text v)
         (set-column! text this v))

    (define/public (get-text)
         (get-column text this))
    (super-new)))

