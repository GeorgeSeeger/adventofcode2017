var fs = require('fs');

var boolFuncs = {
  "<": (val, i) => val < i,
  ">": (val, i) => val > i,
  "<=": (val, i) => val <= i,
  ">=": (val, i) => val >= i,
  "==": (val, i) => val == i,
  "!=": (val, i) => val != i,
}

var incFuncs = {
  "dec": (val, i) => val - i,
  "inc": (val, i) => val + i
}

var isAllowed = (tokens, register) => {
  return boolFuncs[tokens[5]](register[tokens[4]] || 0, tokens[6]);
}
  

var CpuSlave = (line, register, maxes) => {
  var tokens = line.split(' ');
  var address = tokens[0];
  if (!register[address]) register[address] = 0;
  if (isAllowed(tokens, register)) {
    register[address] = incFuncs[tokens[1]] (register[address] || 0, +tokens[2])    
  }
  maxes.push(getMaxOf(register));
}

var solve = (input) => {
  var register = {};
  var maxes = [];
  for(var i =0; i < input.length; i++) {
    CpuSlave(input[i], register, maxes);
  }
  console.log(Math.max(...maxes));
  return register
}

var getMaxOf = (reg) => Math.max(...Object.keys(reg).map(key => reg[key]));

fs.readFile("input", "utf8", (err, data) =>{
  var input = data.split("\n");
  var reg = solve(input);
  console.log(reg);
  console.log(getMaxOf(reg));
}); 