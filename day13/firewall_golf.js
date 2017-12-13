var layers = [];
require('fs').readFileSync("./input", "utf8").split("\n").forEach(line => layers[+line.split(": ")[0]] = +line.split(": ")[1]);
var catches = t => layers.reduce((a, r, d) => (r && (d + t) % (2 * (r - 1)) == 0) || t % 4 == 0  ? a + 1 : a, 0);

console.log(layers.reduce((a, r, d) => (r && d % (2 * (r - 1)) == 0) ? a + d * r : a, 0));
var t = 0; 
while (catches(++t) > 0) { }
console.log(t);