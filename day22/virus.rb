class Virus
  attr_reader :grid, :infections, :infected, :dir, :pos
  def initialize input, size
    @grid = Array.new(size) {Array.new(size, ".")}
    put_in_middle input.map(&:chars)
    @pos = [(@grid.length/2).to_i, (@grid.first.length / 2).to_i]
    @dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    @dir = [-1, 0]
    @infections = 0
  end

  def burst
    if val == "#"
      turn_right
    elsif val == "."
      turn_left
    elsif val == "F"
      turn_around
    end
    clean_or_infect
    move    
  end

  private
  def move
    @pos[0] += @dir[0]
    @pos[1] += @dir[1]
  end

  def val 
    @grid[@pos[0]][@pos[1]]
  end

  def set_val(x)
    @grid[@pos[0]][@pos[1]] = x
  end

  def turn_left
    index = @dirs.find_index(@dir)
    @dir = @dirs[index - 1]
  end

  def turn_right
    index = @dirs.find_index(@dir)
    @dir = @dirs[(index + 1) % 4]
  end

  def turn_around
    @dir = @dir.map{|i| i * -1}
  end

  def clean_or_infect
    if val == "."
      set_val('W')
    elsif val == "W"
      @infections += 1
      set_val("#")
    elsif val == "#"
      set_val('F')
    else
      set_val('.')
    end  
  end

  def put_in_middle arr
    low = @grid.length / 2 - arr.length / 2
    low_inner = @grid.first.length / 2 - arr.first.length / 2
    (low...low+arr.length).each do |i|
      (low_inner...low_inner+arr.length).each do |j|
        @grid[i][j] = arr[i - low][j - low_inner]
      end
    end
    
  end
end

test = "..#/#../...".split("/")
virus = Virus.new(File.open("./day22/input").each_line.map(&:chomp).to_a, 1001)
10000000.times do |i|
  virus.burst
  # puts virus.grid.map{|g| g.join("")}
  # sleep(0.02)
  # system("clear")
  puts "#{i/100000}% done" if i %100000 == 0
end
puts virus.infections