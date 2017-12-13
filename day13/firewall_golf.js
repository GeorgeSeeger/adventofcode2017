var input = require('fs').readFileSync("./input", "utf8").split("\n").map(s => s.split(": ").map(r => +r));

var impacts = t => input.filter(a => (a[0] + t) % (2 * (a[1] - 1)) == 0);

console.log(impacts(0).reduce((a, b) => a + b[0] * b[1], 0));
var time = 0; 
while (impacts(++time).length > 0) { }
console.log(time + "ms");