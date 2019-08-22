#lang racket

(require db "../lib/db.rkt" racket/runtime-path)

(provide create-db
         migration1
         migration2
         migration3)

(define-runtime-path here ".")

(define connection
  (sqlite3-connect #:database (build-path here "./temp.db")
                   #:mode 'create))

(provide 
  create-db
  migration1
  migration2)

(define (migration1)
  (query-exec connection
              "CREATE TABLE posts( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, text TEXT NOT NULL);"))

(define (migration2)
  (query-exec connection
          "CREATE TABLE comments( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, text TEXT NOT NULL);")) 

(define (migration3)
  (query-exec connection
          "CREATE TABLE users( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, first_name TEXT NOT NULL, last_name TEXT NOT NULL);")) 

(define (create-db)
  (migration1) 
  (migration2))

