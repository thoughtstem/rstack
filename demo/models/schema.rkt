#lang racket

(require db "../lib/db.rkt")

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


(define (create-db)
  (migration1) 
  (migration2))

