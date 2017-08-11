$grid = 50

def save_dat(filename,data)
  s = data.pack("d*")
  puts filename
  open(filename,"wb") do |f|
    f.write s
  end
end

def pos2index(x,y,z)
  ix = x.to_i
  iy = y.to_i
  iz = z.to_i
  ix + iy * $grid + iz * $grid**2
end

def put_ball(x,y,z,data)
  r = 8
  (-r..r).each do |ix|
    (-r..r).each do |iy|
      (-r..r).each do |iz|
        i = pos2index(x+ix,y+iy,z+iz)
        v = 1.0 - (ix**2 + iy**2+iz**2).to_f/(r**2)
        next if v < 0.0
        data[i] = data[i] + v 
        data[i] = 1.0 if data[i] > 1.0
      end
    end
  end
end

def makedat
  r = $grid/2 - 8
  steps = 100
  data = Array.new($grid**3){0}
  steps.times do |i|
    filename = sprintf("data%03d.dat",i)
    s = 2.0*Math::PI*i/steps
    x = $grid/2 + r*Math.cos(s)
    y = $grid/2 + r*Math.sin(3.0*s)
    z = $grid/2 + r*Math.sin(2.0*s)
    put_ball(x,y,z,data)
    save_dat(filename,data)
    data.map!{|v| v*0.95}
  end
end

makedat
