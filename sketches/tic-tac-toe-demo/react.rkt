#
#ang racket

(require web-server/servlet
         web-server/servlet-env)

(require "./HelloWorld.rkt" "js.rkt"
         "./react-compiler.rkt")

(define (start req)
  (response/xexpr
    `(html (head (title "Hello world!"))
           (body 
             (script ([src "https://unpkg.com/react@16/umd/react.development.js"] 
                      [crossorigin ""]))
             (script ([src "https://unpkg.com/react-dom@16/umd/react-dom.development.js"] 
                      [crossorigin ""]))

             (div ([id "root1"]))
             (div ([id "root2"]))


             ,(react-declare HelloWorld)

             ,(react-render "root1"
                            HelloWorld
                            (object [color "yellow"])
                            #f)

             ,(react-render "root2"
                            HelloWorld
                            (object [color "red"])
                            ;#f
                            ;TODO: Children are not quite working...
                            
                            (div ([style (color "green")])
                                 "I'm a child"))
             ))))

(serve/servlet start
               #:servlet-path "/"
               #:servlet-regexp #rx""
               #:listen-ip #f)
