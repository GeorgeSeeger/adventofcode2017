using System;
using C.Sharp.Solutions.Day15;
using C.Sharp.Solutions.Day4;
using C.Sharp.Solutions.Day5;

namespace C.Sharp.Solutions {
    public class AdventOfCode {
        public static void Main(string[] args) {
            var kata = new Judge(116, 299);
            Console.WriteLine(kata.CountMatches(40000000));
            kata = new Judge(116, 299);
            Console.WriteLine(kata.CountGoodMatches(5000000));
            Console.WriteLine("Press any key to exit");
            Console.ReadKey(true);
        }
    }
}