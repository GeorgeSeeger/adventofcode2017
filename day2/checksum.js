const fs = require('fs');

var findEvenlyDivisible = (arr, index = 0) => {
  var denom = arr[index];
  if (!denom) return;
  var ans = arr.find((numerator) => numerator % denom == 0 && numerator != denom)
  return ans ? ans / denom : findEvenlyDivisible(arr, index + 1);
}

var findCheckSums = (input) => {
  var checksum = input.reduce((acc, v) =>  acc + Math.max(...v) - Math.min(...v), 0);
  console.log(checksum);

  var checkEvens = input.reduce((acc, v) => acc + findEvenlyDivisible(v), 0);
  console.log(checkEvens)
}

var file = fs.readFile('input', 'utf8', (err, data) =>{
  var input = data.split('\n').map((str, i) => str.split('\t').map(x => +x));  
  input.pop();
  findCheckSums(input);
}
);

findCheckSums([[5, 9, 2, 8],
               [9, 4, 7, 3],
               [3, 8, 6, 5]])