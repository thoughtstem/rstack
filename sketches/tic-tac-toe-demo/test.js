"use strict";
function doAlert(){return (alert("HI"));};
function Square(props){return ((React["createElement"])("button",{onClick:props["onClick"]},props.value));};
function renderSquare(i){return ((React["createElement"])(Square,{value:"X",onClick:doAlert},false));};
function Board(props){var row1=((React["createElement"])("div",false,[(renderSquare(0)),(renderSquare(1)),(renderSquare(2))])),row2=((React["createElement"])("div",false,[(renderSquare(3)),(renderSquare(4)),(renderSquare(5))])),row3=((React["createElement"])("div",false,[(renderSquare(6)),(renderSquare(7)),(renderSquare(8))]));return ((React["createElement"])("div",false,[row1,row2,row3]));};
((ReactDOM.render)(((React["createElement"])(Board,false,false)),((document["getElementById"])("root"))));
