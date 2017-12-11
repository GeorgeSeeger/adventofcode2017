class HexGridParser
  def initialize instr
    @instr = instr
    @dirs = { n: :s,
              se: :nw,
              sw: :ne }
  end

  def get_distance
    w = walk_ends_at
    w.map(&:abs).push(w.reduce(&:+).abs).max
  end

  def walk_ends_at
    axial_unit_vectors = [[0,1],[-1, 0],[1, -1]]
    @dirs.keys.map{|dim| count_dim(dim)}
              .map.with_index{|c, i| axial_unit_vectors[i].map{|j| j * c}}
              .reduce([0,0]){|a, c| a.zip(c).map{|z| z.reduce(&:+)}}
  end

  def count_dim dim
    @instr.count{|s| s == dim.to_s} - @instr.count{|s| s == @dirs[dim].to_s}
  end
end

input = File.open("./input").each_line.first.chomp.split(',')
p HexGridParser.new(input).get_distance
dists = []
input.each.with_index do |e, i|
  dists.push(HexGridParser.new(input.first(i+1)).get_distance)
end
p dists.max


