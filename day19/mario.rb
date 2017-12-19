class Mario
  attr_reader :chars
  def initialize input
    @dirs = [[0,1],[-1,0],[0,-1],[1,0]]
    @dir = [1,0]
    @position = [0,input.first.chars.find_index("|") + 1]
    @map = input
    @chars = []
    traverse
  end

  def traverse
    until at_the_end
      p val
      move_forward
      @chars.push val if /[A-Za-z]/.match val
      turn_corner if val == "+"
    end
  end

  def move_forward
    @position[0] += @dir[0]
    @position[1] += @dir[1]
  end

  def peep(dir)
    [@position[0] + dir[0], @position[1] + dir[1]]
  end

  def val(dir = @dir)
    @map[dir[0]][dir[1]]
  end

  def turn_corner
    dirs = @dirs - [@dir.map{|i| -1 * i}]
    dirs.each do |dir|
      @dir = dir if val(peep(dir)) == "-" || val(dir) == "|"
    end
  end

  def at_the_end
    !/[A-Z]/.match(val).nil? && @dirs.map{|d| val(peep(d))}.count{|s| s == " " } == 3
  end
end

input = File.open("./day19/input").each_line.map(&:chomp)
mario = Mario.new(input)
p mario.chars.join("")