class Spinlock
  def initialize jump
    @jump = jump
    @buffer = [0]
    @position = 0
    inserts
  end

  def inserts
    2017.times do |i|
      @position = (@position + @jump) % @buffer.length
      insert_after_position i + 1 
    end
  end

  def find_after_last
    @buffer[@position + 1]
  end

  def find_first_after_50mil
    position = 0
    answer = 0
    50000000.times do |i|
      position = ((position + @jump) % (i + 1)) + 1
      answer = i + 1 if position == 1
    end
    answer
  end
  
  private
  def insert_after_position i
    @buffer = @buffer[0..@position] + [i] + @buffer[@position+1..-1]
    @position += 1
  end
end

input = 394
spin = Spinlock.new(input)
puts spin.find_after_last
puts spin.find_first_after_50mil

