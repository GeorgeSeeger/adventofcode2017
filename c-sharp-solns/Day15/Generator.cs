using System;
using System.Collections.Generic;
using System.Text;

namespace C.Sharp.Solutions.Day15 {
    public class Generator {
        private readonly int multiplier;
        private readonly int tolerance;

        private long value;

        public Generator(int start, int multiplier, int tolerance) {
            this.value = start;
            this.multiplier = multiplier;
            this.tolerance = tolerance;
        }

        public int NextValue() {
            this.value = (this.value * this.multiplier) % 2147483647;
            return (int) this.value;
        }

        public int NextGoodValue() {
            while (true) {
                this.NextValue();
                if (this.value % this.tolerance == 0) return (int) this.value;
            }
        }
    }

    public class Judge {
        public Generator B { get; set; }

        public Generator A { get; set; }

        public Judge(int inputA, int inputB) {
            this.A = new Generator(inputA,  16807, 4);
            this.B = new Generator(inputB, 48271, 8);
        }

        public int CountMatches(int limit) {
            var count = 0;
            var modulo = (int)Math.Pow(2, 16);
            for (var i = 0; i < limit; i++) {
                if (this.A.NextValue() % modulo == this.B.NextValue() % modulo) count++;
            }
            return count;
        }

        public int CountGoodMatches(int limit) {
            var count = 0;
            var modulo = (int)Math.Pow(2, 16);
            for (var i = 0; i < limit; i++) {
                if (this.A.NextGoodValue() % modulo == this.B.NextGoodValue() % modulo) count++;
            }
            return count;
        }

    }
}
