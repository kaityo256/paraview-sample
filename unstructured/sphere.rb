# frozen_string_literal: true

Point = Struct.new(:x, :y, :z)
filename = "sphere.vtk"
f = open(filename, "w")
puts filename

vp = Array.new(10000) do
  z = rand*2-1.0
  s = rand*2.0*Math::PI
  x = (1-z**2)**0.5*Math.cos(s)
  y = (1-z**2)**0.5*Math.sin(s)
  Point.new(x, y, z)
end

f.puts "# vtk DataFile Version 2.0"
f.puts "unstructured"
f.puts "ASCII"
f.puts "DATASET UNSTRUCTURED_GRID"
f.puts "POINTS #{vp.size} float"
vp.each do |v|
  f.puts "#{v.x} #{v.y} #{v.z}"
end

f.puts "POINT_DATA #{vp.size}"
f.puts "VECTORS vector float"
vp.each do |v|
  f.puts "#{v.y} #{-v.x} 0"
end

f.puts "SCALARS z float"
f.puts "LOOKUP_TABLE defalut"
vp.each do |v|
  f.puts v.z.to_s
end
