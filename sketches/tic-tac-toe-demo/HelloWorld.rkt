#lang at-exp racket

(require (prefix-in js: "./js.rkt")
         "./react-compiler.rkt")

(provide HelloWorld)

(react HelloWorld
   (constructor (props)
      (initState 
        (js:object [x props])))

   (render ()
      (div ([style (js:object (padding 20) 
                              (backgroundColor this.props.color)
                              (color "white")
                              (textAlign "center")
                              (width 200)
                              (height 200))])
          "Hello, World"
          this.props.children
          )))

#;
(displayln HelloWorld)
