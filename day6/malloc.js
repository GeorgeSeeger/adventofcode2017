var fs = require('fs');

var getState = (memoryBanks) => memoryBanks.join(',');

var allocateMemory = (banks, max, maxIndex) => {
    banks[maxIndex] = 0;            
     for(var i = maxIndex + 1; i <= max + maxIndex; i++) {
        var index = (i) % banks.length;
        banks[index] += 1;
     }
}

var malloc = (memoryBanks) => {
    var memo = [];
    var banks = memoryBanks;
    while (!memo.includes(getState(banks))) {
        memo.push(getState(banks));
        var max = Math.max(...banks);
        var maxIndex = banks.findIndex((i) => i == max);
        allocateMemory(banks, max, maxIndex);
    }
    memo.push(getState(banks));
    return memo;
}

var file = fs.readFile('input.txt', 'utf8', (err, data) =>{
    var input = data.split('\n')[0].split('\t').map(x => +x);  
    var getLoop = (memo) => memo.length - memo.findIndex((s) => s == memo[memo.length - 1]) - 1;
    
    var testMemo = malloc([0,2,7,0]);    
    console.log(`There were ${testMemo.length - 1} iterations`);  //5
    console.log(`Loop size was ${getLoop(testMemo)}`)   //4  

    var memo = malloc(input);
    console.log(`There were ${memo.length - 1} iterations`);        
    console.log(`Loop size was ${getLoop(memo)}`)
  });
