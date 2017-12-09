class Group
  attr_accessor :score
end

class Garbage
  attr_accessor :content
  def initialize 
    @content = ""
  end
end

class StreamReader
  attr_reader :groups, :garbages
  def initialize(str)
    @groups = []
    @garbages = []
    process_stream str
  end

  def process_stream(str)
    i = 0
    score = 0
    isInGarbage = false
    while i < str.length
      char = str[i]
      if isInGarbage
        case char
        when "!"
          i += 1
        when '>'
          isInGarbage = false
        else
          @garbages.last.content += char
        end
      else
        case char
        when "{"
          score += 1
          @groups.push Group.new
          @groups.last.score = score
        when "}"
          score -= 1
        when "<"
          isInGarbage = true
          @garbages.push Garbage.new
        end
      end

      i+=1
    end
  end
end

streams = StreamReader.new(File.open("./input").each_line.first)
puts streams.groups.map(&:score).reduce(&:+)
puts streams.garbages.map(&:content).map(&:length).reduce(&:+)
