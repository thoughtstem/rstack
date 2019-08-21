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

    (define/public (set-text v)
         (set-column! text this v))

    (define/public (get-text)
         (get-column text this))
    (super-new)))


;TODO: Figure out why we can't put this in
; its own file.

(provide comment%)

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



