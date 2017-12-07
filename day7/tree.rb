class Program
  attr_accessor :parent
  attr_reader :weight, :name, :sub_tower, :sub_names

  def initialize str
    @name = str.split(' ').first
    @weight = str.split(' ')[1].gsub(/\(|\)/, "").to_i
    @sub_names = str.include?('->') ? str.split('->').last.strip.split(', ') : []
  end

  def assemble_tower programs
    @sub_tower = []
    @sub_names.each do |n|
      @sub_tower.push( programs.select{|p| p.name == n}.first)
      @sub_tower.each do |sp| sp.parent = self end
    end
  end

  def balance?
    return true if !@sub_tower.any?
    oneOfThemWeights = @sub_tower.first.total_weight
    @sub_tower.all?{ |p| p.total_weight == oneOfThemWeights }
  end

  def total_weight
    @weight + (weights_of_each.reduce(&:+) || 0)
  end

  def weights_of_each
    @sub_tower.map{|p| p.total_weight}
  end
end

class ProgramTree
  attr_reader :base, :unbalanced

  def initialize
    @programs = File.open('./input').each_line.map{|str| Program.new(str)}.reject(&:nil?)
    @base = find_bottom @programs
    @programs.each do |p| p.assemble_tower @programs end
    @unbalanced = find_unbalanced @base
  end

  def find_bottom arr
    topProgram = arr.select{|p| !p.sub_names.any? }.first
    bottomProgram = false
    while !bottomProgram
      lowerProgram = arr.select{ |p| 
        p.sub_names.include? topProgram.name
      }.first
      bottomProgram = topProgram if lowerProgram.nil?
      topProgram = lowerProgram
    end
    bottomProgram
  end

  def find_unbalanced program
    return program if program.balance?
    weights = program.sub_tower.map(&:total_weight)
    find_unbalanced program.sub_tower.select{|p| weights.count{|w| w == p.total_weight} == 1 }.first
  end
end


tree = ProgramTree.new
puts tree.base.name
puts "#{tree.unbalanced.name} is #{tree.unbalanced.weight} weight, total of #{tree.unbalanced.total_weight}
  it should total #{tree.unbalanced.parent.sub_tower.select{|p| p.balance?}.first.total_weight}"