class Program
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
    end
  end

  def balance?
    return true if !@sub_tower.any?
    @sub_tower.all?{ |p| p.weight}
  end

  def total_weight
    @weight + @sub_tower.map{|p| p.total_weight}.reduce(:+)
  end
end

class ProgramTree
  attr_reader :base, :unbalanced

  def initialize
    @programs = File.open('./input').each_line.map{|str| Program.new(str)}
    @base = find_bottom programs
    @programs.each do p.assemble_tower programs end
    @unbalanced = find_unbalanced programs
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

  def find_unbalanced arr
    consider = find
    
  end
end


puts ProgramTree.new.base.name
