s=File.open("input.txt").lines.first.chomp
p (0...s.length).reduce(0){|a,i|a+=s[i]==s[i-1]?s[i].to_i :0}