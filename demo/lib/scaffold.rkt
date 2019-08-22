#lang racket

(provide scaffold-delete
         scaffold-update
         scaffold-show
         scaffold-index
         scaffold-make
         scaffold-edit)

(require "../models/main.rkt"
         "./params.rkt")

(define (scaffold-edit resource% i)
  (edit-form resource% i))

(define (scaffold-make resource%)
  (edit-form resource%))

(define (edit-form resource% (i #f))
  (define resource-name (class->string resource%))
  (define plural-resource-name (pluralize resource-name))

  (list
    `(h1 ,(if i "Edit" "Create"))
    `(form ([action ,(if i
                       (~a "/" plural-resource-name "/" i)
                       (~a "/" plural-resource-name))]
            [method ,resource-name])
       ,@(form-fields-and-labels resource%)

       (input ([type "submit"] [value "Submit"])))))


(define (column-name->form-field-and-label name)
  (list
    (~a name ":")
    `(br)
    `(input ([type ,(~a name)] [name ,(~a name)]))
    `(br)
    ))

(define (form-fields-and-labels resource%)
  (apply append
         (map column-name->form-field-and-label
              (class->columns resource%))) )

(define (scaffold-update resource% i)
  (define p (find resource% i))

  (define columns (class->columns resource%))
  
 ;Creates div for displaying text

  (define column-divs
    (map (curry column->div p) columns))

  (define (set obj f v)
    (dynamic-set-field!
      f
      obj
      v))

  (for ([f (class->columns resource%)]) 
    (set p f (params f)))   

  (save p)

  (scaffold-show resource% i))

(define (scaffold-index resource%)
  (define rs (all resource%))

  (define plural-resource-name
    (pluralize (class->string resource%)))

  (define links (map (curry show-link plural-resource-name) rs))


  ;Create page with links
  (list
    `(div (p ,(~a "There are " (length rs) " " plural-resource-name)))

    `(div ,@links) 

    `(br)
    `(br)
    `(br)
    
    `(a ([href ,(~a "/" plural-resource-name "/make")]) "Make new one")))

(define (show-link plural-resource-name p)
  (define path (~a "/" plural-resource-name "/" (get-id p)))

  `(div (a ([href ,path]) 
           ,(send p get-text))))


(define (scaffold-delete resource% i)
  (define p (find resource% i))

  (destroy p)

  ;Note: The user never sees this,
  ;  The delete action gets called by an Ajax request

  `(message ,(~a (string-titlecase (class->string resource%)) 
                 " deleted!")))

(define (column->div resource column-name)
  `(div 
     (div ([style "width: 100px; display: inline-block; margin: 2px;"]) 
          ,(~a column-name)) 
     (div ([style "width: 100px; display: inline-block; margin: 2px;"]) 
          ,(~a (dynamic-get-field column-name resource)))))

(define (scaffold-show resource% i)
  (define lowercase-resource-name 
    (pluralize (class->string resource%)))

  ;Get the resource with id = i

 (define p (find resource% i))

 (define columns (class->columns resource%))
  
 ;Creates div for displaying text

  (define column-divs
    (map (curry column->div p) columns))

  (list
    `(h1 ,(~a "This is a " (class->string resource%)))

    ;TODO: Display resource-specific data here...

    `(div ,@column-divs)

    `(br)
    `(br)
    `(br)

    `(div 
       (a ([href ,(~a "/" lowercase-resource-name "/" i "/edit")]) "Edit"))  

    (delete-button lowercase-resource-name i)

    `(br)
    `(br)
    `(br)

    `(div (a ([href ,(~a "/" lowercase-resource-name)]) 
             ,(~a "Back to " lowercase-resource-name)))))



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

