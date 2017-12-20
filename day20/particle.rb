class Vector
  attr_reader :x, :y, :z
  def initialize(arr)
    @x = arr[0]
    @y = arr[1]
    @z = arr[2]
  end

  def dist_from_origin
    [@x, @y, @z].map(&:abs).reduce(&:+)
  end

  def add(v)
    @x += v.x 
    @y += v.y
    @z += v.z 
  end

  def eql?(other)
    return true if @x == v.x && @y == v.y && @z == v.z
    false
  end
end

class Particle
  attr_reader :index, :position
  def initialize input, index
    @index = index
    @position = Vector.new(/p=<(.*?)>/.match(input)[1].split(",").map(&:to_i))
    @velocity = Vector.new(/v=<(.*?)>/.match(input)[1].split(",").map(&:to_i))
    @acceleration = Vector.new(/a=<(.*?)>/.match(input)[1].split(",").map(&:to_i))
  end

  def dist 
    @position.dist_from_origin
  end

  def move
    @velocity.add(@acceleration)
    @position.add(@velocity)
  end
end

class Box
  def initialize(input)
    @input = input
  end

  def closest_to_origin
    particles = @input.map.with_index{|l, i| Particle.new(l, i)}
    1000.times do   particles.each{|p| p.move} end
    particles.min_by{|p| p.dist }.index
  end

  def remaining_after_collisions
    particles = @input.map.with_index{|l, i| Particle.new(l, i)}
    1000.times do 
      particles.each do |p| p.move end
      collisions = particles
                  .group_by{|p| [p.position.x, p.position.y, p.position.z]}
                  .select{|k, v| v.length > 1 }
                  .map{|k, v| v}
                  .flatten
      particles.reject!{|p| collisions.include?(p) }
    end
    particles.length
  end
end

input = File.open("./day20/input").each_line.to_a

box = Box.new(input)
p box.closest_to_origin
p box.remaining_after_collisions