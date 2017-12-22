class Virus
  attr_reader :grid, :infections, :infected, :dir, :pos
  def initialize input
    @grid = input.map(&:chars)
    @pos = [(input.length/2).to_i, (input.first.length / 2).to_i]
    @dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    @dir = [-1, 0]
    @infected = @grid.map.with_index{|g, i| g.map.with_index{|v, j| v == '#' ? [i, j] : nil }.reject(&:nil?)}.flatten(1)
    @infections = 0
  end

  def burst
    if val == "#"
      turn_right
    else
      turn_left
    end
    clean_or_infect
    move    
  end

  private
  def move
    @pos[0] += @dir[0]
    @pos[1] += @dir[1]
    expand
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

  def clean_or_infect
    if val == "."
      set_val('#')
      @infections += 1 #unless @infected.include?(@pos)
      # @infected.push(@pos.dup)
    else
      set_val('.')
    end  
  end

  def expand
    if @pos[0] < 0
      @pos[0] += 1
      @grid.unshift(Array.new(@grid.first.length, "."))
      @infected.each{|a| a[0] += 1}
    elsif @pos[0] >= @grid.length
      @grid.push(Array.new(@grid.first.length, "."))
    end
    if @pos[1] < 0
      @pos[1] += 1
      @grid.each{|a| a.unshift('.')}
      @infected.each{|a| a[1] += 1}
    elsif @pos[1] >= @grid.first.length
      @grid.each{|a| a.push('.')}
    end
  end
end

test = "..#/#../...".split("/")
virus = Virus.new( File.open("./day22/input").each_line.to_a)
10000.times do
   virus.burst
  #  puts virus.grid.map{|g| g.join("")}
  #  p [virus.infections, virus.pos, virus.dir]
  #  sleep(0.01)
  #  system("clear")
end
#puts virus.grid.map{|g| g.join("")}
puts virus.infections