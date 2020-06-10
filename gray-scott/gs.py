import matplotlib.pyplot as plt
import numpy as np
from numba import jit


@jit
def laplacian(m, n, s):
    ts = 0.0
    ts += s[m + 1][n]
    ts += s[m - 1][n]
    ts += s[m][n + 1]
    ts += s[m][n - 1]
    ts -= 4.0 * s[m][n]
    return ts


@jit
def calc(u, v, u2, v2):
    (L, _) = u.shape
    dt = 0.2
    F = 0.04
    k = 0.06075
    Du = 0.1
    Dv = 0.05
    lu = np.zeros((L, L))
    lv = np.zeros((L, L))
    for ix in range(1, L - 1):
        for iy in range(1, L - 1):
            lu[ix, iy] = Du * laplacian(ix, iy, u)
            lv[ix, iy] = Dv * laplacian(ix, iy, v)
    cu = -v * v * u + F * (1.0 - u)
    cv = v * v * u - (F + k) * v
    u2[:] = u + (lu + cu) * dt
    v2[:] = v + (lv + cv) * dt


@jit
def simulation(L, loop):
    u = np.zeros((L, L))
    u2 = np.zeros((L, L))
    v = np.zeros((L, L))
    v2 = np.zeros((L, L))
    h = L // 2
    u[h - 6:h + 6, h - 6:h + 6] = 0.9
    v[h - 3:h + 3, h - 3:h + 3] = 0.7
    r = []
    for i in range(loop):
        calc(u, v, u2, v2)
        u, u2, v, v2 = u2, u, v2, v
        if i % 100 == 0:
            r.append(v.copy())
    return r


def save_imgs(imgs):
    n = len(imgs)
    for i in range(4):
        filename = f"conf{i:04}.png"
        plt.imsave(filename, imgs[n // 4 * i])


def save_as_vtk(filename, img):
    f = open(filename, "w")
    print(filename)
    L = len(img)
    f.write("# vtk DataFile Version 1.0\n")
    f.write(f"{filename}\n")
    f.write("ASCII\n")
    f.write("DATASET UNSTRUCTURED_GRID\n")
    f.write(f"POINTS {img.size} float\n")
    for i in range(L):
        for j in range(L):
            f.write(f"{i} {j} 0\n")
    f.write(f"CELLS {img.size} {img.size*2}\n")
    for i in range(img.size):
        f.write(f"1 {i}\n")
    f.write(f"CELL_TYPES {img.size}\n")
    for _ in range(img.size):
        f.write(f"1\n")
    f.write(f"POINT_DATA {img.size}\n")
    f.write("SCALARS scalars float\n")
    f.write("LOOKUP_TABLE default\n")
    img = img.reshape(L * L)
    for i in range(img.size):
        f.write(f"{img[i]:.03f}\n")


imgs = simulation(80, 1000)

for i in range(len(imgs)):
    save_as_vtk(f"conf{i:03}.vtk", imgs[i])

# imgs = simulation(80, 15000)
# save_imgs(imgs)
