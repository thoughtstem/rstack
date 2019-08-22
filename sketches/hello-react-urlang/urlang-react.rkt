#lang racket

(provide output)

(require urlang)

(define output
  (with-output-to-string
    (thunk
      (urlang
        (urmodule test 
                  (import React ReactDOM console document) 

                  (define (Hello props)
                    (console.log "Hello")
                    (console.log props)
                    (React.createElement "div" #f
                                         (+ "Hello " props.toWhat)))

                  (ReactDOM.render
                    (React.createElement Hello 
                                         (object [toWhat "World"]) 
                                         #f)
                    (document.getElementById "root")))))))



