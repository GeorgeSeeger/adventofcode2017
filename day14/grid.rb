require "../day10/circular_list.rb"
input = 'hxtvlmkl'


def make_grid(input)
  (0...128).map{|i| "#{input}-#{i}"}
          .map{|s| Hasher.hash_string(s)}
          .map{|s| s.chars.map{|c| c.to_i(16).to_s(2).rjust(4, "0")}.join("")}
end

puts make_grid(input).join("").chars.count{|c| c == "1"}