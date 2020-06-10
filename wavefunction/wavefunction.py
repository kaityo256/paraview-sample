from math import exp


def p_2pz(x, y, z, r):
    return exp(-r * 3.0) * (z)


def p_3dz2(x, y, z, r):
    return exp(-r * 4.0) * (3 * z**2 - r**2)


def p_3dzx(x, y, z, r):
    return exp(-r * 4.0) * (z * x)


def export_vtk(filename, p):
    print(filename)
    grid = 10
    dim = grid * 2 + 1
    points = dim**3
    f = open(filename, "w")
    f.write(f"""\
# vtk DataFile Version 1.0"
Wavefunction
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS {dim} {dim} {dim}
ORIGIN 0.0 0.0 0.0
SPACING 1.0 1.0 1.0
POINT_DATA {points}
SCALARS scalars float
LOOKUP_TABLE default\
  """)
    for ix in range(dim):
        for iy in range(dim):
            for iz in range(dim):
                x = ix / grid - 1.0
                y = iy / grid - 1.0
                z = iz / grid - 1.0
                r = (x * x + y * y + z * z)**0.5
                f.write(str(p(x, y, z, r)))
                f.write("\n")


export_vtk("2pz.vtk", p_2pz)
export_vtk("3dz2.vtk", p_3dz2)
export_vtk("3dzx.vtk", p_3dzx)
