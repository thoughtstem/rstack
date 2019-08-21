#lang racket

(provide scaffold-delete
         scaffold-show)

(require "../models/main.rkt")

(define (scaffold-delete resource% i)
  (define p (find resource% i))

  (destroy p)

  ;Note: The user never sees this,
  ;  The delete action gets called by an Ajax request

  `(message ,(~a (string-titlecase (class->string resource%)) 
                 " deleted!")))


(define (scaffold-show resource% i)
  (define lowercase-resource-name 
    (pluralize (class->string resource%)))

  ;Get the resource with id = i

 (define p (find resource% i))

 ;TODO: Procedurally get column names and resolve them to their
 ;values
 (define t (send p get-text))
 
 ;Create div for displaying text

  (list
    `(h1 ,(~a "This is a " (class->string resource%)))

    ;TODO: Display resource-specific data here...
    `(div ,t)

    `(div 
       (a ([href ,(~a "/" lowercase-resource-name "/" i "/edit")]) "Edit"))  

    (delete-button lowercase-resource-name i)

    `(br)
    `(br)
    `(br)

    `(div (a ([href ,(~a "/" lowercase-resource-name)]) 
             ,(~a "Back to " lowercase-resource-name)))
    
    ))



(define (delete-button lowercase-resource-name i)
  ;TODO: Clean this up. It's a mess.
  (define delete-js
    (~a
      "const Http = new XMLHttpRequest(); const url=\"/"
      lowercase-resource-name "/" i
      "\"; Http.open(\"DELETE\", url); Http.onload=function(){window.location=\"/"
      lowercase-resource-name 
      "\";}; Http.send();   "))

 `(button ([onClick ,delete-js])
     "Delete"))

