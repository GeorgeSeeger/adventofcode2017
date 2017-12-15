require "../day10/circular_list.rb"
input = 'hxtvlmkl'

class DiskGrid
  def initialize(input)
    @input = input
    @grid = make_grid input
    @neighbour_offsets = [0, -1, 1].permutation(2).reject{|a| a.reduce(&:+) == 0}
  end

  def make_grid(input)
    (0...128).map{|i| "#{input}-#{i}"}
            .map{|s| Hasher.hash_string(s)}
            .map{|s| s.chars.map{|c| c.to_i(16).to_s(2).rjust(4, "0").chars}.flatten}
  end

  def count_squares
    @grid.flatten.count{|c| c == "1"}
  end

  def count_regions
    @marked_grid = @grid.clone
    regions = 0
    while (@marked_grid.any?)
      @marked_grid.first.each.with_index do |e, i|
        if (e == "1")
           group_fill [[0, i]]
           regions += 1
        end
      end
      @marked_grid.shift
    end
    regions
  end
  private 

  def group_fill(coords)
    return unless coords.any?

    new_coords = coords.map{ |c|
      get_val(c) == "1" ? get_neighbours(c) : nil
    }.flatten(1)
    .reject{|c| c.nil? || get_val(c) == "0"}

    coords.each do |c| 
      @marked_grid[c.first][c.last] = "0"
    end
    group_fill(new_coords)
  end

  def get_val(c)
    @marked_grid[c.first][c.last]
  end

  def get_neighbours(c)
    @neighbour_offsets
          .map{|a| [ c[0]+a[0], c[1]+a[1] ]}
          .reject{|c| c.any?{|i| i < 0} || c[0] >= @marked_grid.length || c[1] >= @marked_grid.first.length}
  end 
end

grid = DiskGrid.new(input)
puts grid.count_squares
puts grid.count_regions