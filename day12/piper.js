var fs = require('fs');

class Proggy {
  constructor(name) {
    this.name = name;
    this.programs = [];
  }

  pipeTo(program) {
    this.programs.push(program);
  }
}

class PipeMaster {
  constructor(input) {
    this.programs = this.process(input);
  }

  process(input) {
    var programs = [];
    input.forEach(line => {
      var l = line.split(" <-> ")
      programs.push(new Proggy(l[0]));
    });

    input.forEach(line => {
      var l = line.split(" <-> ");
      var prog = programs.find(p => p.name == l[0])
      l[1].split(', ')
          .map(name => programs.find(p => p.name == name))
          .forEach(p => prog.pipeTo(p));  
    });

    return programs;
  }

  findAllConnectedTo(name) {
    var program = this.programs.find(p => p.name == name);
    var group = [program];
    var nextGen = program.programs;
    while (nextGen.length > 0) {
      nextGen.forEach(p => group.push(p));
      nextGen = nextGen.map(p => p.programs);
      nextGen = [].concat.apply([], nextGen) //flatten
                          .filter(p => !group.map(pr => pr.name).includes(p.name)); 
    }
    return group;
  }

  findAllGroups() {
    var groups = [];
    var programsToFind = this.programs;
    while (programsToFind.length > 0) {
      var group = this.findAllConnectedTo(programsToFind[0].name);
      groups.push(group);
      programsToFind = programsToFind.filter(p => !group.includes(p));
    }
    return groups;
  }
}

var data = fs.readFileSync('./input', 'utf8')
var input = data.split("\n");
var pipeMaster = new PipeMaster(input);
console.log(pipeMaster.findAllConnectedTo("0").length);
console.log(pipeMaster.findAllGroups().length);
