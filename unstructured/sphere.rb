Point = Struct.new(:x, :y, :z)

vp = Array.new(10000) do 
  z = rand()*2-1.0
  s = rand()*2.0*Math::PI
  x = (1-z**2)**0.5*Math::cos(s)
  y = (1-z**2)**0.5*Math::sin(s)
  Point.new(x,y,z)
end

puts "# vtk DataFile Version 2.0"
puts "test"
puts "ASCII"
puts "DATASET UNSTRUCTURED_GRID"
puts "POINTS #{vp.size} float"
vp.each do |v|
  puts "#{v.x} #{v.y} #{v.z}"
end

puts "POINT_DATA #{vp.size}"
puts "VECTORS vector float"
vp.each do |v|
  puts "#{v.y} #{-v.x} #{0}"
end

puts "SCALARS length float"
puts "LOOKUP_TABLE defalut"
vp.each do |v|
  puts "#{Math.sqrt(v.x**2 + v.y**2)}"
end

