class Captcha

    def initialize(numStr) 
        @numStr = numStr
    end

    def solve_first
        (-1...@numStr.length - 1).reduce(0){ |sum, i|
            sum += @numStr[i] == @numStr[i + 1] ? @numStr[i].to_i : 0
        }
    end

    def solve_second
        (-1...@numStr.length - 1).reduce(0){ |sum, i|
            displace = i + @numStr.length / 2
            displace -= displace >= @numStr.length ? @numStr.length : 0
            sum += @numStr[i] == @numStr[displace] ? @numStr[i].to_i : 0
        }
    end

end

puts Captcha.new(File.open("input.txt").each_line.first.chomp).solve_first
puts Captcha.new(File.open("input.txt").each_line.first.chomp).solve_second
