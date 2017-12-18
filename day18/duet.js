class Duet {
    constructor(input, id, queue) {
        this.input = input;
        this.pointer = 0;
        this.reg = {};
        this.queue = queue;
        this.id = id;
        this.awaiting = false;
        this.initReg(id);
        this.fcts = {
            "add": (a, v) => this.reg[a] += v,
            "mul": (a, v) => this.reg[a] *= v,
            "set": (a, v) => this.reg[a] = +v,
            "mod": (a,v ) => this.reg[a] %= v,
            "jgz": (a, v) => (+a > 0 || isNaN(a) && this.reg[a] > 0) ? this.pointer += v - 1 : v,
            "snd": (a) => this.queue.enqueue(id, isNaN(a) ?  this.reg[a] : +a ),
            "rcv": (a) => this.receiveAt(a),
        }
        this.carryOut();
    }

    initReg(id) {
       this.input.map(inst => inst.split(' ')[1]).filter(v => isNaN(v)).forEach(a => this.reg[a] = 0);
       this.reg["p"] = id;
    }

    carryOut() {
        for (;this.pointer >= 0 && this.pointer < this.input.length && !this.awaiting; this.pointer++) {
            var getVal = (val) => isNaN(val) ? (Object.keys(this.reg).includes(val) ? this.reg[val] : null) : +val;
            var inst = this.input[this.pointer].split(" ");
            this.fcts[inst[0]](inst[1], getVal(inst[2]));
        }
    }

    receiveAt(a) {
        var id = this.id == 0 ? 1 : 0;
        if (this.queue.queues[id].length == 0) {
            this.awaiting = true;
        } else {
            this.reg[a] = this.queue.dequeue(id)
        }
    }
}

class MessageQueue {
    constructor() {
        this.p1Counter=0;
        this.queues = { 0: [], 1: []};
    }

    enqueue(id, val) {
        if (id == 1) this.p1Counter++;
        this.queues[id].push(val);
    }

    dequeue(id) {
        return this.queues[id].pop();
    }
}


var fs = require("fs");
var input = fs.readFileSync("./day18/input", "utf8").split("\n");
// var input = fs.readFileSync("./test", "utf8").split("\r\n");
var queue = new MessageQueue();
var p0 = new Duet(input, 0, queue);
var p1 = new Duet(input, 1, queue);

while (Object.values(queue.queues).some(a => a.length > 0)) {
    p0.carryOut();
    p1.carryOut();
}

console.log(queue.p1Counter);