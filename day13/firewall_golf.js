var input = require('fs').readFileSync("./input", "utf8");

var ans = input.split("\n").map(s => s.split(": ").map(t => +t)).filter(a => a[0] % (2 * (a[1] - 1)) == 0).reduce((a, b) => a + b[0] * b[1], 0);

console.log(ans);