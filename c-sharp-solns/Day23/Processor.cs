using System;
using System.Collections.Generic;
using System.Linq;

namespace C.Sharp.Solutions.Day23 {
  public class Processor {
    private int pointer;
    public int Counter;
    private Dictionary<char, int> registers;
    private Dictionary<string, Func<char,int, int>> funcs;
    private readonly List<string> instructions;

    public Processor(List<string> input) {
      this.pointer = 0;
      this.Counter = 0;
      this.registers = new Dictionary<char, int>("abcdefgh".ToList().Zip(new int[8], (c, i) => new KeyValuePair<char, int>(c, i) ));
      this.funcs = new Dictionary<string, Func<char, int, int>> {
        {"set", (c, i) =>  this.registers[c] = i },
        {"jnz", (c, i) => this.pointer += (c == '1' || this.registers[c] != 0 ? i - 1 : 0) },
        {"mul", (c, i) => { this.Counter++; this.registers[c] *= i; return this.registers[c]; }},
        {"sub", (c, i) => this.registers[c] -= i }
      };
      this.instructions = input;       
    }

    public void CarryOut() {
      for (this.pointer = 0; this.pointer < this.instructions.Count; this.pointer++){
        var inst = this.instructions[this.pointer].Split(" ");
        int val;
        if (!int.TryParse(inst[2], out val)) val = this.registers[char.Parse(inst[2])];

        this.funcs[inst[0]](char.Parse(inst[1]), val);
      }
    }
  }
}