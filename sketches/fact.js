"use strict";
((console.log)(false));
function fact(n){return (((n===0)===false)?(n*(fact((n-1)))):1);};
(fact(5));
exports.fact=fact;
