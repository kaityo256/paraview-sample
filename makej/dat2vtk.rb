if ARGV.size < 1
  puts "usage: dat2vtk.dat filename.dat"
  exit
end

datfile = ARGV[0]
data = File.binread(datfile).unpack("d*")
grid = 50
points = grid**3

puts <<"EOS"
# vtk DataFile Version 1.0"
#{datfile}
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS #{grid} #{grid} #{grid}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0
POINT_DATA #{points}
SCALARS scalars float
LOOKUP_TABLE default
EOS
data.each do |v|
  puts v 
end
