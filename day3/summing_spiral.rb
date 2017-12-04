class SummingSpiral
  attr_reader :spiral

  def initialize
    @spiral = [[1]]
    @dir = 'u'
    @ind = [@spiral.length/2, @spiral.length - 1]
  end

  def add_next
    add_next_band if @spiral.length ** 2 == @spiral.flatten.reject(&:nil?).length
    cell = get_cell

    while (!cell.nil?) do
      next_ind
      cell = get_cell
    end
    cell = sum_of_neighbours(@ind)
    assignTo(@ind, cell)
    cell
  end

  private

  def add_next_band
    nil_array = Array.new(@spiral.length)
    @spiral.push nil_array.clone
    @spiral.unshift nil_array.clone
    @spiral.each do |a|
      a.push nil
      a.unshift nil
    end
    @ind = [@spiral.length - 2, @spiral.length - 1]
  end

  def get_cell(indices = @ind)
    @spiral[indices.first][indices.last]
  end

  def next_ind(ind = @ind)
    case @dir
      when 'u'
        ind[0] -= 1
      when 'l'
        ind[1] -= 1
      when 'd'
        ind[0] += 1
      when 'r'
        ind[1] += 1
    end
    @dir = 'l' if (ind[0] == 0 && ind[1] == (@spiral.length - 1))
    @dir = 'd' if (ind[0] == 0 && ind[1] == 0)
    @dir = 'r' if (ind[0] == (@spiral.length - 1) && ind[1] == 0)
    @dir = 'u' if (ind[0] == (@spiral.length - 1) && ind[1] == (@spiral.length - 1))

    @ind = ind

    return ind
  end

  def sum_of_neighbours(indices)
    list = get_neighbours(indices)
    list.map{|ind| get_cell(ind) }.reject(&:nil?).inject(&:+)
  end

  def get_neighbours(ind)
    (-1..1).map{ |i| 
      (-1..1).map{|j|
        [ind[0] + i, ind[1] + j] unless i == 0 && j == 0
      }
    }.flatten(1)
    .reject(&:nil?)
    .reject{ |a| a.any?{|i| i < 0 || i >= @spiral.length } }
  end

  def assignTo(ind, val) 
    @spiral[ind.first][ind.last] = val
  end
end

spr = SummingSpiral.new
magic_number = 265149
until (cell = spr.add_next) > magic_number; end
p cell
