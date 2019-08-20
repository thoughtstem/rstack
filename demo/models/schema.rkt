#lang racket

(require db racquel racket/runtime-path)

(provide (all-from-out racquel))

(provide save
         all
         get-id
         find
         destroy

         connection

         create-db
         migration1
         migration2)

(define-runtime-path here ".")

(define connection
  (sqlite3-connect #:database (build-path here "./temp.db")
                   #:mode 'create))


(define (migration1)
  (query-exec connection
              "CREATE TABLE posts( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, text TEXT NOT NULL);"))

(define (migration2)
  (query-exec connection
          "CREATE TABLE posts( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, text TEXT NOT NULL);")) 


(define (create-db)
  (migration1) 
  (migration2))

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


