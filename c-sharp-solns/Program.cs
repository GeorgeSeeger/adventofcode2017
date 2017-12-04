using System;
using C.Sharp.Solutions.Day4;

namespace C.Sharp.Solutions {
    public class AdventOfCode {
        public static void Main(string[] args) {
            var validator = new PassphraseValidator();
            Console.WriteLine(validator.NumberOfValidPassphrases);
            Console.WriteLine(validator.NumberOfReallyValidPassphrases);
            Console.WriteLine("Press any key to exit");
            Console.ReadKey(true);
        }
    }
}