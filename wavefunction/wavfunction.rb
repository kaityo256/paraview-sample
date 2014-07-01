def export_vtk(filename,p)
  f = open(filename,"w")
  puts filename
  grid = 10
  dim = grid*2+1
  points = dim**3
  f.puts "# vtk DataFile Version 1.0"
  f.puts "Wavefunction"
  f.puts "ASCII"
  f.puts "DATASET STRUCTURED_POINTS"
  f.puts "DIMENSIONS #{dim} #{dim} #{dim}"
  f.puts "ORIGIN 0.0 0.0 0.0"
  f.puts "ASPECT_RATIO 1.0 1.0 1.0"
  f.puts
  f.puts "POINT_DATA " + points.to_s
  f.puts "SCALARS scalars float"
  f.puts "LOOKUP_TABLE default"
  for iz in -grid..grid
    for iy in -grid..grid
      for ix in -grid..grid
      x = ix.to_f/grid
      y = iy.to_f/grid
      z = iz.to_f/grid
      r = (x*x + y*y + z*z)**0.5
      f.puts p.call(x,y,z,r)
      end
    end
  end
end

p_2pz = lambda{|x,y,z,r| Math.exp(-r*3.0)*(z)}
p_3dz2 = lambda{|x,y,z,r| Math.exp(-r*4.0)*(3*z**2 - r**2)}
p_3dzx = lambda{|x,y,z,r| Math.exp(-r*4.0)*(z*x)}

export_vtk("2pz.vtk",p_2pz)
export_vtk("3dz2.vtk",p_3dz2)
export_vtk("3dzx.vtk",p_3dzx)
