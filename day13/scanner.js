var fs = require('fs')
var data = fs.readFileSync('./input', 'utf8');

class Layer {
  constructor(str) {
    this.depth = +str.split(': ')[0]
    this.range = +str.split(': ')[1]
    this.scannerPosition = 0;
    this.moves = 0;
  }

  moveNext() {
    var increment = this.moves % (this.range - 1) % 2 == 0 ? 1 : -1;
    this.moves++;
    this.scannerPosition += increment;
  }

  get severity() {
    return this.depth * this.range;
  }
}

class Firewall {
  constructor(input) {
    var layers = input.map(line => new Layer(line));
    this.length = Math.max(...layers.map(l => l.depth));
    this.layers = new Array(this.length);
    layers.forEach((l, i) => this.layers[l.depth] = l);
    this.intruderPosition = -1;
  }

  get severity() {
    var severity = 0;
    while (this.intruderPosition < this.length) {
      this.intruderPosition++;
      var layer = this.layers[this.intruderPosition];
        console.log(layer);
        if ( layer && layer.scannerPosition == 0){
        severity += layer.severity
      }
      this.layers.forEach(l => l.moveNext());
    }
    // console.log(this.layers)
    return severity;
  }
}

var firewall = new Firewall(data.split("\n"));
console.log(firewall.severity);