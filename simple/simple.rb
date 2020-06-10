# frozen_string_literal: true

grid = 10
dim = grid*2+1
points = dim**3
r = 0.8

f = open("simple.vtk", "w")

f.puts <<"EOS"
# vtk DataFile Version 1.0
test
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS #{dim} #{dim} #{dim}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0

POINT_DATA #{points}

SCALARS intensity float
LOOKUP_TABLE default
EOS

(-grid..grid).each do |iz|
  (-grid..grid).each do |iy|
    (-grid..grid).each do |ix|
      x = ix.to_f/grid
      y = iy.to_f/grid
      z = iz.to_f/grid
      v = r*r - (x*x + y*y + z*z)
      v = 0 if v < 0
      f.puts v.to_s
    end
  end
end
