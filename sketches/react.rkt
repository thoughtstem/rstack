#lang web-server/insta

(define (start req)
  (response/xexpr
    `(html (head (title "Hello world!"))
           (body 
             (div ([id "root"]))
           (script ([src "https://unpkg.com/react@16/umd/react.development.js"] 
	            [crossorigin ""]))
           (script ([src "https://unpkg.com/react-dom@16/umd/react-dom.development.js"] 
	            [crossorigin ""]))

                 (script 
                   "

function Hello(props)
{
    console.log(\"Hello\")
    console.log(props)
    return React.createElement('div', null, \"Hello \" + props.toWhat);
}


ReactDOM.render(
  React.createElement(Hello, {toWhat: 'World'}, null),
  document.getElementById('root')
);
")))))

