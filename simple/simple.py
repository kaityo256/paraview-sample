grid = 10
dim = grid * 2 + 1
points = dim**3
r = 0.8

f = open("simple.vtk", "w")

f.write(f"""\
# vtk DataFile Version 1.0
test
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS {dim} {dim} {dim}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0

POINT_DATA {points}

SCALARS intensity float
LOOKUP_TABLE default
""")

for ix in range(dim):
    for iy in range(dim):
        for iz in range(dim):
            x = ix / grid - 1.0
            y = iy / grid - 1.0
            z = iz / grid - 1.0
            v = r * r - (x * x + y * y + z * z)
            if v < 0:
                v = 0
            f.write(str(v))
            f.write("\n")
