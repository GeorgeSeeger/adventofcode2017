using System;
using System.IO;
using System.Linq;

using C.Sharp.Solutions.Day15;
using C.Sharp.Solutions.Day23;
using C.Sharp.Solutions.Day4;
using C.Sharp.Solutions.Day5;

namespace C.Sharp.Solutions {
    public class AdventOfCode {
        public static void Main(string[] args) {
            var processor = new Processor(File.ReadAllText("./Day23/input").Split("\n").ToList());
            processor.CarryOut();
            Console.WriteLine(processor.Counter);
            Console.WriteLine("Press any key to exit");
            Console.ReadKey(true);
        }
    }
}