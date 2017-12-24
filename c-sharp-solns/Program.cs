using System;
using System.IO;
using System.Linq;

using C.Sharp.Solutions.Day15;
using C.Sharp.Solutions.Day23;
using C.Sharp.Solutions.Day24;
using C.Sharp.Solutions.Day4;
using C.Sharp.Solutions.Day5;

namespace C.Sharp.Solutions {
    public class AdventOfCode {
        public static void Main(string[] args) {
            Day24();
            Console.WriteLine("Press any key to exit");
            Console.ReadKey(true);
        }

        private static void Day23() {
            var processor = new Processor(File.ReadAllText("./Day23/input").Split("\n").ToList());
            processor.CarryOut();
            Console.WriteLine(processor.Counter);
        }

        private static void Day24() {
            var bridgeFactory = new BridgeBuilder(File.ReadAllLines("./Day24/input").ToList());
            Console.WriteLine(bridgeFactory.Strongest().Strength());
            Console.WriteLine(bridgeFactory.Longest().Strength());
            
        }
    }
}