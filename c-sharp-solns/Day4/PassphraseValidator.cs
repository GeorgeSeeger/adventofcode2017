using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace C.Sharp.Solutions.Day4 {
    public class PassphraseValidator {
        public Passphrase[] Passphrases;

        public int NumberOfValidPassphrases;

        public int NumberOfReallyValidPassphrases;

        public PassphraseValidator() {
            this.Passphrases = File.OpenText("./Day4/input.txt").ReadToEnd().Split('\n').Where(s => !string.IsNullOrEmpty(s)).Select(s => new Passphrase(s)).ToArray();
            this.NumberOfValidPassphrases =  this.Passphrases.Count(p => p.IsValid());
            this.NumberOfReallyValidPassphrases = this.Passphrases.Count(p => p.IsReallyValid());
        }
    }

    public class Passphrase {
        private readonly string[] phrases;

        public Passphrase(string phrase) {
            this.phrases = phrase.Split(' ');
        }

        public bool IsValid() {
            return this.phrases.All(s => this.phrases.Count(str => str == s) == 1);
        }

        public bool IsReallyValid() {
            var ordered = this.phrases.Select(s => s.OrderBy(c => c)).Select(oc => string.Join("", oc)).ToArray();
            return ordered.All(s => ordered.Count(str => str == s) == 1);
        }
    }
}
