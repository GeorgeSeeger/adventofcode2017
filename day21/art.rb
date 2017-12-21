class Art
  attr_reader :canvas
  def initialize input
    @rules = process_rules input
    @canvas = to_arr ".#./..#/###"
  end

  def iterate
    if @canvas.length % 2 == 0 
      chunks = grid_chunk(@canvas, 2).map{ |chunk|
        the_chunk = transforms(chunk).map{|c| to_str(c)}.find{|c| @rules.has_key?(c)}
        to_arr @rules[the_chunk]
      }
      @canvas = join(chunks, 3)
    elsif @canvas.length % 3 == 0 
      chunks = grid_chunk(@canvas, 3).map{ |chunk|
        the_chunk = transforms(chunk).map{|c| to_str(c)}.find{|c| @rules.has_key?(c)}
        to_arr @rules[the_chunk]
      }
      @canvas = join(chunks, 4)
    end
  end

  def count_on
    @canvas.flatten.count{|c| c == "#" }
  end

  def grid_chunk(arr, size)
    lim = arr.length / size
    (0...lim).map{|i|
      (0...lim).map{|j|
        (0...size).map{|k|
          (0...size).map{|l| 
            arr[i * size + k][j * size + l]
          }
        }
      }
    }.flatten(1)
  end

  def join(chunks, size)
    arr = chunks.flatten
    lim = Math.sqrt(arr.length).to_i
    (0...lim/size).map{|h|
      (0...size).map{|i|
        (0...lim/size).map{|j|
          (0...size).map{|k|
            arr[(lim*size) * h + size * i + (size*size)*j + k]
          }
        }.flatten
      }
    }.flatten(1)
  end

  def transforms(arr)
    [arr, rotate(arr), rotate(rotate(arr)), rotate(rotate(rotate(arr)))].map{|a| [flip_hor(a), a.reverse]}.flatten(1)
  end

  def rotate(arr)
    arr.reverse.transpose
  end

  def flip_hor arr
    arr.map(&:reverse)
  end

  def process_rules input
    rules = {}
    input.each do |line|
      l = line.split(" => ");
      rules[l[0]] = l[1]
    end
    rules
  end

  def to_arr str
    str.split('/').map(&:chars)
  end

  def to_str arr
    arr.map{|a| a.join("")}.join("/")
  end
end

input = File.open("./day21/input").each_line.map(&:chomp)
art = Art.new(input)
5.times do art.iterate end
p art.count_on
13.times do art.iterate end
p art.count_on