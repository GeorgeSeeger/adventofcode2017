class Dance
  def initialize(input)
    @config = (97...113).map(&:chr)
    @input = input
    dance @input
  end

  def dance_billion
    configs = []
    billion = 1000000000
    billion.times do |i|
      dance @input
      return configs[billion % i - 2] if configs.include? positions()
      configs.push positions()
    end
  end

  def dance(input)
    input.each do |move| execute move end
  end

  def positions
    @config.join("")
  end

  private
  def execute(move)
    if (move[0] == "s") then @config.rotate!(-move[1..-1].to_i) end
    if (move[0] == "x") then exchange(move) end
    if (move[0] == "p") then partner(move) end
  end

  def exchange(move)
    nums = move.split("/").map{|x| x[/\d+/].to_i}
    chr = @config[nums[0]]
    @config[nums[0]] = @config[nums[1]]
    @config[nums[1]]= chr    
  end
  
  def partner(move)
    nums = [move[1], move[3]].map{|c| @config.find_index{|d| d == c}}
    exchange("x#{nums[0]}/#{nums[1]}")
  end
end

dance = Dance.new(File.open("./input").each_line.first.chomp.split(","))

puts dance.positions
puts dance.dance_billion