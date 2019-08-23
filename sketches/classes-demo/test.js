"use strict";
function Square(props){return ((React["createElement"])("button",{onClick:props["onClick"]},props.value));};
function Board(props){((React["Component"].call)(this));return (this.state=props);};
(Board.prototype=((Object.create)(React["Component"].prototype)));
(Board.prototype.renderSquare=((i) => {return ((React["createElement"])(Square,{value:"X",onClick:((this.props["onClick"])(i))},false));}));
(Board.prototype.render=(() => {return ((this["renderSquare"])(0));}));
((ReactDOM.render)(((React["createElement"])(Board,{values:[" "," "," "," "," "," "," "," "," "]})),((document["getElementById"])("root"))));
