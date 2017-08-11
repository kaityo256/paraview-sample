DAT=$(shell ls *.dat)
VTK=$(DAT:.dat=.vtk)

.SUFFIXES: .vtk .dat

all:$(VTK)

.dat.vtk:
	ruby dat2vtk.rb $< > $@

clean:
	rm -f *.vtk *.dat
