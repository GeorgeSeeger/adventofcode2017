class Duet {
    constructor(input, id, sendQ, receiveQ) {
        this.input = input;
        this.pointer = 0;
        this.reg = {};
        this.sendQ = sendQ;
        this.receiveQ = receiveQ;
        this.awaiting = false;
        this.initReg(id);
        this.fcts = {
            "add": (a, v) => this.reg[a] += v,
            "mul": (a, v) => this.reg[a] *= v,
            "set": (a, v) => this.reg[a] = +v,
            "mod": (a,v ) => this.reg[a] %= v,
            "jgz": (a, v) => (+a > 0 || isNaN(a) && this.reg[a] > 0) ? this.pointer += v - 1 : v,
            "snd": (a) => this.sendFrom(a),
            "rcv": (a) => this.receiveAt(a),
        }
    }

    initReg(id) {
       this.input.map(inst => inst.split(' ')[1]).filter(v => isNaN(v)).forEach(a => this.reg[a] = 0);
       this.reg["p"] = id;
    }

    carryOut() {
        this.awaiting = false;
        for (;this.pointer >= 0 && this.pointer < this.input.length && !this.awaiting; this.pointer++) {
            var getVal = (val) => isNaN(val) ? (Object.keys(this.reg).includes(val) ? this.reg[val] : null) : +val;
            var inst = this.input[this.pointer].split(" ");
            this.fcts[inst[0]](inst[1], getVal(inst[2]));
        }
    }
    sendFrom(a) {
        var out = isNaN(a) ? this.reg[a] : +a;
        this.awaiting = true;
        this.sendQ.enqueue(out);
    }
    receiveAt(a) {
        if (this.receiveQ.length == 0) {
            this.awaiting = true;
        } else {
            this.reg[a] = this.receiveQ.dequeue()
        }
    }
}

class MessageQueue {
    constructor() {
        this.sendCounter = 0;
        this.queue = [];
    }
    get length() {
        return this.queue.length;
    }

    enqueue(val) {
        this.sendCounter++;
        this.queue.push(val);
    }

    dequeue() {
        return this.queue.shift();
    }
}


var fs = require("fs");
var input = fs.readFileSync("./day18/input", "utf8").split("\n");
// var input = fs.readFileSync("./test", "utf8").split("\r\n");
// var input = `snd 1
// snd 2
// snd p
// rcv a
// rcv b
// rcv c
// rcv d`.split("\n");
var queue0 = new MessageQueue();
var queue1 = new MessageQueue();
var p0 = new Duet(input, 0, queue0, queue1);
var p1 = new Duet(input, 1, queue1, queue0);

do {
    p1.carryOut();
    p0.carryOut();
    console.log(queue0.length + " & " + queue1.length )
} while (queue0.length > 0 || queue1.length > 0)

console.log(queue1.sendCounter / 2);