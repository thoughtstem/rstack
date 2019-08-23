#lang racket

(provide output)

(require urlang)

(define output
  (with-output-to-string
    (thunk
      (urlang
        (urmodule test 
                  (import
                    Object
                   this
                   this.state
                   React.Component.call
                   Board.prototype
                   Board.prototype.renderSquare
                   Board.prototype.render
                   React ReactDOM console document alert) 


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

                  (define (Board props)
                    (React.Component.call this)
                    (:= this.state props))

                  (:= Board.prototype
                      (Object.create React.Component.prototype))

                  (:= Board.prototype.renderSquare
                      (lambda (i)
                        (React.createElement Square
                                             (object 
                                              [value "X"]
                                              [onClick (this.props.onClick i)])
                                             #f)))

                  (:= Board.prototype.render
                      (lambda ()
                        (this.renderSquare 0)))
                  

                  
                  


                  ;============================
                  ; Main
                  ;============================
                  (ReactDOM.render
                    (React.createElement Board (object
                                                [values (array " " " " " " " " " " " " " " " " " ")]  
                                                       ))
                    (document.getElementById "root")))))))



