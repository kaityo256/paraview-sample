grid = 10
dim = grid*2+1
points = dim**3
r = 0.8
puts "# vtk DataFile Version 1.0"
puts "test"
puts "ASCII"
puts "DATASET STRUCTURED_POINTS"
printf "DIMENSIONS %d %d %d\n",dim, dim, dim
puts "ORIGIN 0.0 0.0 0.0"
puts "ASPECT_RATIO 1.0 1.0 1.0"
puts
puts "POINT_DATA " + points.to_s
puts "SCALARS scalars float"
puts "LOOKUP_TABLE default"
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
