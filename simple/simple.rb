grid = 10
dim = grid*2+1
points = dim**3
r = 0.8

puts <<"EOS"
# vtk DataFile Version 1.0
test
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS #{dim} #{dim} #{dim}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0

POINT_DATA #{points}
SCALARS scalars float
LOOKUP_TABLE default
EOS

for ix in -grid..grid
  for iy in -grid..grid
    for iz in -grid..grid
    x = ix.to_f/grid
    y = iy.to_f/grid
    z = iz.to_f/grid
    v = r*r - (x*x + y*y + z*z)
    v = 0 if v < 0
    puts v.to_s
    end
  end
end
