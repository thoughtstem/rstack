#lang racket

(provide output)

(require urlang)

(define output
  (with-output-to-string
    (thunk
      (urlang
        (urmodule test 
                  (import React ReactDOM console document alert) 

                  (define (doAlert)
                    (alert "HI"))

                  ;============================
                  ; Square
                  ;============================

                  (define (Square props)
                    (React.createElement "button"
                                         (object
                                           [onClick props.onClick])
                                         props.value))


                  ;============================
                  ; Board
                  ;============================
                  (define (renderSquare i)
                    (React.createElement Square
                                         (object 
                                           [value "X"]
                                           [onClick doAlert])
                                         #f))
                  (define (Board props)
                    (var 
                      (row1
                        (React.createElement "div" #f
                                             (array
                                               (renderSquare 0)  
                                               (renderSquare 1)
                                               (renderSquare 2))))
                      (row2
                        (React.createElement "div" #f
                                             (array
                                               (renderSquare 3)  
                                               (renderSquare 4)
                                               (renderSquare 5))))
                      (row3
                        (React.createElement "div" #f
                                             (array
                                               (renderSquare 6)  
                                               (renderSquare 7)
                                               (renderSquare 8)))))
                    
                    (React.createElement "div" #f
                                         (array row1 row2 row3)))


                  ;============================
                  ; Main
                  ;============================
                  (ReactDOM.render
                    (React.createElement Board #f #f)
                    (document.getElementById "root")))))))



