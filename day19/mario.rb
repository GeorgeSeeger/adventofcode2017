class Mario
  attr_reader :chars, :steps
  def initialize input
    @dirs = [[0,1],[-1,0],[0,-1],[1,0]]
    @dir = [1,0]
    @position = [0,input.first.chars.find_index("|")]
    @map = input
    @chars = []
    @steps = 0
    traverse
  end

  def traverse
    until at_the_end?
      move_forward
      @chars.push val if /[A-Z]/.match val
      turn_corner if val == "+"
    end
    move_forward    
  end

  def move_forward
    @steps += 1
    @position[0] += @dir[0]
    @position[1] += @dir[1]
  end

  def peep(dir)
    [@position[0] + dir[0], @position[1] + dir[1]]
  end

  def val(pos = @position)
    @map[pos[0]][pos[1]]
  end

  def turn_corner
    dirs = other_dirs
    dirs.each do |dir|
      @dir = dir if /[A-Z\|\-]/.match(val(peep(dir)))
    end
  end

  def other_dirs
    @dirs - [@dir.map{|i| i * -1}]
  end

  def at_the_end?
    return true if @position.any?{|i| i < 0} ||@position[1] > @map.first.length || @position[0] > @map.length
    /[A-Z]/.match(val) != nil && other_dirs.map{|d| val(peep(d))}.all?{|s| s == " " }
  end
end

input = File.open("./day19/input").each_line.map(&:chomp)
mario = Mario.new(input)
p mario.chars.join("")
p mario.steps