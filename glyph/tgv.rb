# frozen_string_literal: true

grid = 21
c = grid.to_f/2
points = grid**3
filename = "tgv.vtk"
puts filename
f = open(filename, "w")

VectorField = Struct.new(:x, :y, :z)
vf = Array.new(points) do |i|
  ix = i % grid
  iy = (i/grid) % grid
  iz = i/grid/grid
  x = (ix.to_f/grid+0.25)*2.0*Math::PI
  y = (iy.to_f/grid+0.25)*2.0*Math::PI
  z = (iz.to_f/grid+0.25)*2.0*Math::PI
  vx = Math.cos(x) * Math.sin(y) * Math.cos(z)
  vy = -Math.sin(x) * Math.cos(y) * Math.cos(z)
  vz = 0.0
  VectorField.new(vx, vy, vz)
end

f.puts <<"EOS"
# vtk DataFile Version 2.0
test
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS #{grid} #{grid} #{grid}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0

POINT_DATA #{points}
VECTORS velocity float
EOS

vf.each do |v|
  f.puts "#{v.x} #{v.y} #{v.z}"
end

f.puts "SCALARS angle float"
f.puts "LOOKUP_TABLE default"

vf.each do |v|
  f.puts Math.atan2(v.y, v.x).to_s
end
