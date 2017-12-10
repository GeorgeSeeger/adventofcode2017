class CircularList
  attr_reader :values

  def initialize(range = nil)
    @values = range || (0..255).to_a
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


class Hasher
  def initialize input
    @inputs = input
    @list = CircularList.new
    @pos = 0
    @skip = 0
  end

  def knot_hash
    @inputs.each do |len|
      mod = @list.values.length
      @list.reverse_between(@pos, (@pos + len) % mod)
      @pos = (@pos + len + @skip) % mod
      @skip += 1
    end
  end

  def first_task
    knot_hash
    @list.values.first(2).reduce(&:*)
  end

  def hash
    64.times do 
      knot_hash
    end
    @list.values.each_slice(16).map{|s| s.reduce(&:^)}.map{|i| i.to_s(16).rjust(2, "0")}.join
  end

  def self.hash_string(str)
    Hasher.new(str.strip.codepoints.concat([17, 31, 73, 47, 23])).hash
  end
end

puts Hasher.new(File.readlines('./input').first.split(',').map(&:to_i)).first_task
puts Hasher.hash_string(File.readlines('./input').first)
puts Hasher.hash_string("") #a2582a3a0e66e6e86e3812dcb672a272