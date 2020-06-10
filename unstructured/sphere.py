from math import pi, cos, sin
from random import random


class Point:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z


filename = "sphere.vtk"
f = open(filename, "w")
print(filename)

vp = []
for i in range(10000):
    z = random() * 2.0 - 1.0
    s = random() * 2.0 * pi
    x = (1 - z**2)**0.5 * cos(s)
    y = (1 - z**2)**0.5 * sin(s)
    vp.append(Point(x, y, z))

f.write(f"""\
# vtk DataFile Version 2.0
unstructured
ASCII
DATASET UNSTRUCTURED_GRID
POINTS {len(vp)} float
""")

for v in vp:
    f.write(f"{v.x} {v.y} {v.z}\n")

f.write(f"""\
POINT_DATA {len(vp)}
VECTORS vector float
""")

for v in vp:
    f.write(f"{v.y} {-v.x} 0\n")

f.write("SCALARS z float\n")
f.write("LOOKUP_TABLE defalut\n")
for v in vp:
    f.write(f"{v.z}\n")
