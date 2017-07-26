def export_vtk(filename,p)
  puts filename
  grid = 10
  dim = grid*2+1
  points = dim**3
  open(filename,"w") do |f|
    f.puts <<"EOS"
# vtk DataFile Version 1.0"
Wavefunction
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS #{dim} #{dim} #{dim}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0
POINT_DATA #{points}
SCALARS scalars float
LOOKUP_TABLE default
EOS
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
end

p_2pz = lambda{|x,y,z,r| Math.exp(-r*3.0)*(z)}
p_3dz2 = lambda{|x,y,z,r| Math.exp(-r*4.0)*(3*z**2 - r**2)}
p_3dzx = lambda{|x,y,z,r| Math.exp(-r*4.0)*(z*x)}

export_vtk("2pz.vtk",p_2pz)
export_vtk("3dz2.vtk",p_3dz2)
export_vtk("3dzx.vtk",p_3dzx)
