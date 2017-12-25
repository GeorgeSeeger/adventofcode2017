class Turing
  @@states = {
    A: -> (val) { if (val == 0) then return [:B, +1, 1]; else return [:C, -1, 0]; end },
    B: -> (val) { if (val == 0) then return [:A, -1, 1]; else return [:D, +1, 1]; end },
    C: -> (val) { if (val == 0) then return [:B, -1, 0]; else return [:E, -1, 0]; end },
    D: -> (val) { if (val == 0) then return [:A, +1, 1]; else return [:B, +1, 0]; end },
    E: -> (val) { if (val == 0) then return [:F, -1, 1]; else return [:C, -1, 1]; end },
    F: -> (val) { if (val == 0) then return [:D, +1, 1]; else return [:A, +1, 1]; end }
  }

  def initialize
    @tape = Hash.new(0)
    @ptr = 0
    @state = :A
  end

  def step count
    p @@states[@state]
    count.times do
      a = @@states[@state].call val
      set_val a[2]
      @ptr += a[1]
      @state = a[0]
    end
  end

  def val
    @tape[@ptr]
  end

  def set_val(v)
    @tape[@ptr] = v
  end

  def checksum
    @tape.values.count{|i| i == 1}
  end
end

turing = Turing.new
turing.step 12481997
p turing.checksum