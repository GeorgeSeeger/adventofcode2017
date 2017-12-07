using System;
using C.Sharp.Solutions.Day4;
using C.Sharp.Solutions.Day5;

namespace C.Sharp.Solutions {
    public class AdventOfCode {
        public static void Main(string[] args) {
            var kata = new Jumper();
            Console.WriteLine(kata.NumberOfJumps);
            Console.WriteLine("Press any key to exit");
            Console.ReadKey(true);
        }
    }
}