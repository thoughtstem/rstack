#lang racket

(provide post% )

(require racquel 
         "../lib/db.rkt" )

(provide comment%)

(define comment%
  (data-class object%
    (table-name "comments")

    (column (id   #f ;default val
                  "id")
            (user-id #f ;default val
                     "user_id"
                     )
            (comment-id #f ;default val
                        "comment_id"
                        )
            (post-id #f ;default val
                     "post_id"))
    (init-column
      (text #f "text"))  

    (primary-key id)

    (has-many comment% comment_id get-comments)

    (define/public (set-text v)
      (set-column! text this v))

    (define/public (get-text)
         (get-column text this))
    (super-new)))

(define post%
  (data-class object%
    (table-name "posts")

    (column (id   #f ;default val
                  "id")
            (user-id #f ;default val
                     "user_id"))
    (init-column
      (text #f "text"))  

    (primary-key id)

    (join [comments comment% #:cardinality 'one-to-many
                 (where (= (comment% post-id) (post% id)))])

    (has-many comment% post_id get-comments)

    (define/public (set-text v)
         (set-column! text this v))

    (define/public (get-text)
         (get-column text this))
    (super-new)))


(provide user%)

(define user%
  (data-class object%
    (table-name "users")

    (column (id   #f ;default val
                  "id"))
    (init-column
      (first-name "" "first_name")
      (last-name "" "last_name"))  

    (primary-key id)

    (define/public (full-name)
      (~a 
        (get-column first-name this)  
        " "
        (get-column last-name this)))
    (super-new)))



