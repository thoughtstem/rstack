"use strict";
function Hello(props){((console.log)("Hello"));((console.log)(props));return ((React["createElement"])("div",false,("Hello"+props["toWhat"])));};
((ReactDOM.render)(((React["createElement"])(Hello,{toWhat:"World"},false)),((document["getElementById"])("root"))));
