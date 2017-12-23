require 'prime'
b,c,h = 105700,122700,0
while (b <= c) do h += 1 unless b.prime?; b+=17 end
p h