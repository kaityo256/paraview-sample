from math import pi, sin, cos, atan2

grid = 21
c = grid / 2
points = grid**3
filename = "tgv.vtk"
print(filename)
f = open(filename, "w")


class VectorField:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z


vf = []
for i in range(points):
    ix = i % grid
    iy = (i / grid) % grid
    iz = i / grid / grid
    x = (ix / grid + 0.25) * 2.0 * pi
    y = (iy / grid + 0.25) * 2.0 * pi
    z = (iz / grid + 0.25) * 2.0 * pi
    vx = cos(x) * sin(y) * cos(z)
    vy = -sin(x) * cos(y) * cos(z)
    vz = 0.0
    vf.append(VectorField(vx, vy, vz))

f.write(f"""\
# vtk DataFile Version 2.0
test
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS {grid} {grid} {grid}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0

POINT_DATA {points}
VECTORS velocity float
""")

for v in vf:
    f.write(f"{v.x} {v.y} {v.z}\n")

f.write("SCALARS angle float\n")
f.write("LOOKUP_TABLE default\n")

for v in vf:
    f.write(f"{atan2(v.y, v.x)}\n")
