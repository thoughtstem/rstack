#lang racket

(require web-server/servlet web-server/servlet-env
         "../lib/scaffold.rkt" 
         "../lib/resource-dispatcher.rkt" 
         "../lib/params.rkt" 
         "../models/main.rkt")

(provide 
  make
  edit
  update
  create
  show
  delete
  index)


;TODO: Can auto-generate this probably
(define (delete i)
  (scaffold-delete post% i))

(define (show i)
  (scaffold-show post% i))


(define (index)

  ;Get all posts
  (define ps (all post%))

  ;Create links
  (define links (map post-link ps))

  ;Create page with links
  (list
    `(div (p ,(~a "There are " (length ps) " posts")))

    `(div ,@links) 

    `(br)
    `(br)
    `(br)
    
    `(a ([href "/posts/make"]) "New Post")))


(define (post-link p)
  (define path (~a "/posts/" (get-id p)))

  `(div (a ([href ,path]) 
           ,(send p get-text))))


(define (update i)
  (define p (find post% i))
  (send p set-text (params 'text))
  (save p)

  (show i))


(define (make)
  (edit-form))

(define (edit i)
  (edit-form i))

(define (edit-form (i #f))
  (list
    `(h1 ,(if i "Edit" "Create"))
    `(form ([action ,(if i
                       (~a "/posts/" i)
                       "/posts")]
            [method "post"])
       "Text:" 
       (br)
       (input ([type "text"] [name "text"])) 
       (input ([type "submit"] [value "Submit"])))))

(define (create)
  (define p (new post%
                 [text (params 'text)]))

  (save p)

  ;I wish this worked.  Can't get the id
  ;  from racquel.  Opened ticket:
  ;  https://github.com/brown131/racquel/issues/11

  #;
  (show (get-id p))

  ;Just load the index for now...
  
  (index))

