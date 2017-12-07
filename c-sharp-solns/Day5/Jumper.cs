using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace C.Sharp.Solutions.Day5
{
    public class Jumper {
        public int NumberOfJumps { get; }

        private readonly int[] instructions;

        public Jumper() {
            this.instructions = File.ReadLines("./Day5/input.txt").Select(s => int.Parse(s)).ToArray();
            this.NumberOfJumps = this.CarryOutNewJumps();
        }

        private int CarryOutJumps() {
            var index = 0;
            var jumps = 0;
            while (index < this.instructions.Length) {
                var oldIndex = index;
                index += this.instructions[index];
                this.instructions[oldIndex]++;
                jumps++;
            }
            return jumps;
        }

        private int CarryOutNewJumps() {
            var index = 0;
            var jumps = 0;
            while (index < this.instructions.Length) {
                var oldIndex = index;
                var offset = this.instructions[index];
                index += offset;
                this.instructions[oldIndex] += (offset >= 3 ? -1 : 1);
                jumps++;
            }
            return jumps;
        }

    }
}
