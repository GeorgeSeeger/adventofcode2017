namespace C.Sharp.Solutions.Day24 {
  using System;
  using System.Linq;
  using System.Collections.Generic;

  public class BridgeBuilder {
    public IEnumerable<Component> Components { get; }
 
    public List<Bridge> Bridges {get; private set; }
    
    public BridgeBuilder(List<string> input) {
        this.Components = input.Select(s => new Component(s));
        GenerateBridges();
    }

    public Bridge Strongest() {
      return this.Bridges.OrderByDescending(b => b.Strength()).First();
    }

    public Bridge Longest() {
      return this.Bridges.OrderByDescending(b => b.Components.Count).ThenByDescending(b => b.Strength()).First();
    }

    public void GenerateBridges() {
      var baseComponents = this.Components.Where(p => p.Pin1 == 0 || p.Pin2 == 0);
      this.Bridges = baseComponents.Select(c => new Bridge(c, new List<Component>(this.Components))).ToList();
      var newBridges = new List<Bridge>();
      do {
        newBridges = (newBridges.Any() ? newBridges : this.Bridges).SelectMany(b => b.GenerateMore(this.Components)).ToList();
        foreach (var b in newBridges) this.Bridges.Add(b);

      } while (newBridges.Any());
    }
  }

  public class Bridge {
    public List<Component> Components {get; }

    public List<Component> UnusedComponents { get; set; }

    public int UnusedPin {get; private set;}

    public Bridge(Component p, List<Component> uc) {
        this.Components = new List<Component> { p };
        uc.RemoveAll(c => c.Pin1 == p.Pin1 && c.Pin2 == p.Pin2);
        this.UnusedComponents = uc;
        this.UnusedPin = this.AvailablePin();
    }

    public Bridge(List<Component> c, List<Component> uc) {
      this.Components = c;
      uc.Remove(c.Last());
      this.UnusedComponents = uc;
      this.UnusedPin = this.AvailablePin();
    }

    public List<Bridge> GenerateMore(IEnumerable<Component> components) {
      
      return this.UnusedComponents.Where(c => c.Pins().Any(i => i == this.UnusedPin)).Select(c => new Bridge(this.Components.Concat(new[] {c}).ToList(), new List<Component>(this.UnusedComponents))).ToList();
    }

    public int Strength() {
      return this.Components.Select(p => p.Pin1 + p.Pin2).Sum();
    }

    private int AvailablePin() {
      if (this.Components.Count == 1) return this.Components.First().Pins().First(i => i != 0);

      var secondLast = this.Components[this.Components.Count - 2].Pins();
      var pin = this.Components.Last().Pins().FirstOrDefault(i => !secondLast.Contains(i));
      return this.Components.Last().Pins().Distinct().Count() == 2 ? pin : this.Components.Last().Pins().First();

    }
  }

  public class Component {
    public int Pin1 {get; private set;}

    public int Pin2 {get; private set;}
    public Component(string ComponentString) {
        var s = ComponentString.Split("/");
        this.Pin1 = int.Parse(s[0]);
        this.Pin2 = int.Parse(s[1]);
    }

    public int[] Pins() {
      return new[] {this.Pin1, this.Pin2};
    }
  }
}