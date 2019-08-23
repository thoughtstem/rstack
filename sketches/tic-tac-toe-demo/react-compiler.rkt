#lang at-exp racket

(provide react-class
         react
         react-render
         react-declare

         setState 
         initState 
         div)

(require (prefix-in js: "./js.rkt"))
(require (only-in xml cdata))

(require syntax/parse/define)
(require racket/stxparam
         (for-syntax racket))

(define-syntax (expression stx)
  (syntax-parse stx 
    [(_ run-me)
     #`(js:js run-me)]))

(define-syntax-rule (react name 
                           (constructor (props)
                                        constructor-lines ...)
                           (method-name (param ...) lines ... last-line) ...)

  (begin
    (provide name)
    (define name 
      (react-class name
                   (constructor (props) constructor-lines ...)
                   (method-name (param ...) lines ... last-line) 
                   ...))))

(define-syntax-rule (react-render dom-id 
                                  name 
                                  props
                                  children ...)
  `(script
    ,(js:js (ReactDOM.render (React.createElement
                            name
                            props 
                            children ...)
                          (document.getElementById dom-id)
                          )))
  )

(define-syntax-rule (react-declare name)
  `(script ,(cdata 'hi 'there name)))

(define-syntax-rule (react-class name 
                            (constructor (props)
                                         constructor-lines ...)
                            (method-name (param ...) lines ... last-line) ...)
  @~a{
  class @'name extends React.Component{
    constructor(props){
      super(props)  

      @(string-join (list constructor-lines ...) "\n")
    }


    @~a{

     @'method-name (@(string-join (list (~a 'param) ...) ", ")){
        @~a{
          @lines 
        }@...

        return @last-line
      }

    }@...
  }})


(define-syntax-rule (initState v)
  @~a{
  this.state = @(expression v);
  })

(define-syntax-rule (setState v)
  @~a{
  this.setState(@(expression v));
  })

(define-syntax-rule (div ([k v] ...) stuff ...)
  @~a{
    React.createElement("div", @(js:js (js:object [k v] ...)), [ @(string-join (list (expression stuff) ...) ",")]);
  })
