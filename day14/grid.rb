require "../day10/circular_list.rb"
input = 'hxtvlmkl'

class DiskGrid
  def initialize(input)
    @input = input
    @grid = make_grid input
  end

  def make_grid(input)
    (0...128).map{|i| "#{input}-#{i}"}
            .map{|s| Hasher.hash_string(s)}
            .map{|s| s.chars.map{|c| c.to_i(16).to_s(2).rjust(4, "0").chars}.flatten}
  end

  def count_squares
    @grid.map{|ca| ca.join("")}.join("").chars.count{|c| c == "1"}
  end

  def count_regions
    @grid_2 = make_grid(@input)
    regions = 0
    while (@grid_2.any?)
      @grid_2.first.each.with_index do |e, i|
        if (e == "1")
           group_destroy [[0, i]]
           regions += 1
        end
      end
      @grid_2.shift
    end
    regions
  end
  private 

  def group_destroy coords
    return unless coords.any?
    new_coords = []
    coords.each do |c|
      if (get_val(c) == "1") 
        get_neighbours(c).each{|co| new_coords.push co}
      end
      @grid_2[c.first][c.last] = "0"
    end

    group_destroy(new_coords.reject{|c| get_val(c) == "0"})
  end

  def get_val c
    @grid_2[c.first][c.last]
  end

  def get_neighbours coord
    [[coord.first - 1, coord.last], [coord.first + 1, coord.last], [coord.first, coord.last - 1], [coord.first, coord.last + 1]].reject{|c| c.any?{|i| i < 0} || c[0] >= @grid_2.length || c[1] >= @grid_2.first.length}
  end 
end

grid = DiskGrid.new(input)
puts grid.count_squares
puts grid.count_regions