class Duet {
    constructor(input) {
        this.input = input;
        this.lastPlayed = null;
        this.pointer = 0;
        this.recovered = null;
        this.reg = {};
        this.initReg();
        this.fcts = {
            "add": (a, v) => this.reg[a] += v,
            "mul": (a, v) => this.reg[a] *= v,
            "set": (a, v) => this.reg[a] = +v,
            "mod": (a,v ) => this.reg[a] %= v,
            "jgz": (a, v) => (+a > 0 || isNaN(a) && this.reg[a] > 0) ? this.pointer += v - 1 : v,
            "snd": (a) => this.lastPlayed = this.reg[a],
            "rcv": (a) => this.reg[a] > 0 ? console.log(this.recovered = this.lastPlayed) : null,
        }
        this.carryOut();
    }

    initReg() {
       this.input.map(inst => inst.split(' ')[1]).filter(v => isNaN(v)).forEach(a => this.reg[a] = 0);
    }

    carryOut() {
        for (var i = 0;this.pointer >= 0 && i < 2000/* this.pointer < this.input.length */; this.pointer++, i++) {
            var getVal = (val) => isNaN(val) ? (Object.keys(this.reg).includes(val) ? this.reg[val] : null) : +val;
            var inst = this.input[this.pointer].split(" ");
            // console.log(this.input[this.pointer] + ": " + this.pointer)
            this.fcts[inst[0]](inst[1], getVal(inst[2]));
            // console.log(this.reg);
        }
        // console.log(this);
    }
}

var fs = require("fs");
var input = fs.readFileSync("./input", "utf8").split("\n");
// var input = fs.readFileSync("./test", "utf8").split("\r\n");
var duet = new Duet(input);