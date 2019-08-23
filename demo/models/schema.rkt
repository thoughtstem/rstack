#lang racket

(require db "../lib/db.rkt" racket/runtime-path)

(provide migration1
         migration2
         migration3
         migration4)

(define-runtime-path here ".")

(define (migration1)
  (query-exec connection
          "CREATE TABLE posts( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, text TEXT NOT NULL);"))

(define (migration2)
  (query-exec connection
          "CREATE TABLE comments( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, text TEXT NOT NULL);")) 

(define (migration3)
  (query-exec connection
          "CREATE TABLE users( id   INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, first_name TEXT NOT NULL, last_name TEXT NOT NULL);")) 

(define (migration4)
  (query-exec connection
              "ALTER TABLE comments ADD COLUMN post_id INTEGER DEFAULT '0';")
  (query-exec connection
              "ALTER TABLE comments ADD COLUMN comment_id INTEGER DEFAULT '0';")
  (query-exec connection
              "ALTER TABLE comments ADD COLUMN user_id INTEGER DEFAULT '0';")
  (query-exec connection
              "ALTER TABLE posts ADD COLUMN user_id INTEGER DEFAULT '0';"))