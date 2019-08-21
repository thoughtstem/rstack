#lang racket

(require web-server/servlet
         web-server/servlet-env)

(provide resource-dispatcher
         auto-load-dispatcher
         current-req)
  
(define (layout elems)
  `(html (body ,@elems)))


(define current-req (make-parameter #f))

(define-syntax-rule (auto-load-dispatcher folder controller fallback)
  (let ()
    (define controller-file (~a controller ".rkt"))
    (define index (dynamic-require (build-path folder controller-file) 'index))
    (define make (dynamic-require (build-path folder controller-file) 'make))
    (define create (dynamic-require (build-path folder controller-file) 'create))
    (define update (dynamic-require (build-path folder controller-file) 'update))
    (define edit (dynamic-require (build-path folder controller-file) 'edit))
    (define show (dynamic-require (build-path folder controller-file) 'show))
    (define delete (dynamic-require (build-path folder controller-file) 'delete))

    (define short-name (string-replace controller-file ".rkt" ""))
    (define-values (my-dispatcher my-url)
      (resource-dispatcher controller
                           #:index    index
                           #:make     make
                           #:create   create
                           #:update   update
                           #:edit     edit
                           #:show     show
                           #:delete   delete
                           #:fallback fallback))

    my-dispatcher))

(define-syntax-rule (resource-dispatcher resource-name
                                         #:index index
                                         #:make make
                                         #:create create
                                         #:update update
                                         #:edit edit
                                         #:show show
                                         #:delete delete
                                         #:fallback fallback)

  (let ()
    (define (update-fun req i)
      (parameterize
        ([current-req req])
        (response/xexpr (layout (update i)))))

    (define (create-fun req)
      (parameterize
        ([current-req req])
        (response/xexpr (layout (create)))))

    (define (delete-fun req i)
      (parameterize
        ([current-req req])
        (response/xexpr (layout (delete i)))))

    (define (show-fun req i)
      (parameterize
        ([current-req req])
        (response/xexpr (layout (show i)))))

    (define (index-fun req)
      (parameterize
        ([current-req req])
        (response/xexpr (layout (index)))))


    (define (make-fun req)
      (parameterize
        ([current-req req])
        (response/xexpr (layout (make)))))

    (define (edit-fun req i)
      (parameterize
        ([current-req req])
        (response/xexpr (layout (edit i)))))


    (dispatch-rules
      [(resource-name)                                 index-fun]
      [(resource-name "make")                          make-fun]
      [(resource-name (integer-arg) "edit")            edit-fun]
      [(resource-name) #:method "post"                 create-fun]
      [(resource-name (integer-arg)) #:method "post"   update-fun]
      [(resource-name (integer-arg))                   show-fun]
      [(resource-name (integer-arg)) #:method "delete" delete-fun]
      [else fallback])))
