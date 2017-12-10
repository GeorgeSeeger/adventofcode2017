class CircularList
  attr_reader :values

  def initialize(range = (0..255))
    @values = range.to_a
  end

  def reverse_between(i, j)
     j += @values.length if (j < i)

    sub_list = (i...j).map{|k| at(k)}.reverse
    (i...j).each.with_index{|k, l| assignTo(k, sub_list[l])}
  end

  def at(i)
    @values[i % @values.length]
  end

  def assignTo(i, val)
    @values[i % @values.length] = val
  end
end

def carry_out_first(input = nil, list = CircularList.new, pos = 0, skip = 0)
  inputs = input || File.readlines('./input').first.split(',').map(&:to_i)
  inputs.each do |len|
    mod = list.values.length
    list.reverse_between pos, (pos + len) % mod
    pos += len + skip
    pos %= mod
    skip += 1
  end

  puts list.values.first(2).reduce(&:*) if !input
end

def carry_out_second(input = nil)
  list = CircularList.new
  inputs = (input || File.readlines('./input').first.strip).codepoints.concat([17, 31, 73, 47, 23])
  pos = 0
  skip = 0
  (1..64).each do 
    inputs.each do |len|
      mod = list.values.length
      list.reverse_between pos, (pos + len) % mod
      pos += len + skip
      pos %= mod
      skip += 1
    end
  end

  puts list.values.each_slice(16).map{|s| s.reduce(&:^)}.map{|i| i.to_s(16).rjust(2, "0")}.join
end

carry_out_first
carry_out_second
carry_out_second("") #a2582a3a0e66e6e86e3812dcb672a272

