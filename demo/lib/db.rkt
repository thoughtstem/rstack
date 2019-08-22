#lang racket

(require db racquel racket/runtime-path)

(provide (all-from-out racquel))

(provide connection
         save
         all
         get-id
         find
         destroy
         pluralize
         class->string
         class->columns)

(define-runtime-path here ".")

(define connection
  (sqlite3-connect #:database (build-path here "./temp.db")
                   #:mode 'create))


(define (save do)
  (save-data-object connection do))


(define (all do)
  (select-data-objects connection do))


(define (get-id do)
  (get-column id do))

(define (find c i)
  (select-data-object connection c (where (= id ?)) i))

(define (destroy do)
  (delete-data-object connection do))


(define (class->string c%)
  (string-replace 
    (second (string-split (~a c%) ":")) 
    "%>" ""))

;TODO: We need to make this more correct for the English language.
(define (pluralize s)
  (~a s "s"))


(define (class->columns c%)
  (define-values (cik sk tn x columns j pk ak en)
    (data-class-info c%))
  (filter-not 
    (curry eq? 'id)
    (map first columns)))

