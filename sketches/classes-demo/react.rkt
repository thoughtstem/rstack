#lang web-server/insta

(require "./urlang-react.rkt")
(require xml)

(define (start req)
  (response/xexpr
    `(html (head (title "Hello world!"))
           (body 
             (div ([id "root"]))
           (script ([src "https://unpkg.com/react@16/umd/react.development.js"] 
	            [crossorigin ""]))
           (script ([src "https://unpkg.com/react-dom@16/umd/react-dom.development.js"] 
	            [crossorigin ""]))

                 (script ,(cdata 'hi 'there
                                 output))))))

