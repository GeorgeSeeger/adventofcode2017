def whatRingIs(n)
  band = Math.sqrt(n).ceil
  return band - (band % 2) + 1
end

def findDistance(n)
  band = whatRingIs(n)
  side = (0..3).map{|i| 
    lower = (band - 2) ** 2
    (lower + ((band - 1) * i)...lower + ((band - 1) * (i + 1)))
  }.find{|r| r.include? n}

  return band / 2 + (side.to_a.find_index(n) - band / 2).abs
end

p findDistance(23)
p findDistance(1024)

p findDistance(265149)