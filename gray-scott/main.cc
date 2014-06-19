//----------------------------------------------------------------------
#include <iostream>
//----------------------------------------------------------------------
const int L = 80;
double u[L][L], v[L][L];
const double F = 0.04;
const double k = 0.06075;
const double dt = 0.2;
const double Du = 0.05;
const double Dv = 0.1;
//----------------------------------------------------------------------
void init(void) {
  for (int i = 0; i < L; i++) {
    for (int j = 0; j < L; j++) {
      u[i][j] = 0.0;
      v[i][j] = 0.0;
    }
  }

  int d = 3;
  for (int i = L / 2 - d; i < L / 2 + d; i++) {
    for (int j = L / 2 - d; j < L / 2 + d; j++) {
      u[i][j] = 0.7;
    }
  }
  d = 6;
  for (int i = L / 2 - d; i < L / 2 + d; i++) {
    for (int j = L / 2 - d; j < L / 2 + d; j++) {
      v[i][j] = 0.9;
    }
  }
}
//----------------------------------------------------------------------
double
calcU (double tu, double tv) {
  return tu * tu * tv - (F + k) * tu;
};
//----------------------------------------------------------------------
double
calcV (double tu, double tv) {
  return -tu * tu * tv + F * (1.0 - tv);
};
//---------------------------------------------------------------------------
double
laplacian(int ix,int iy,double s[L][L]){
  double ts = 0.0;
  ts += s[ix - 1][iy];
  ts += s[ix + 1][iy];
  ts += s[ix][iy-1];
  ts += s[ix][iy+1];
  ts -= 4.0 * s[ix][iy];
  return ts;
}
//---------------------------------------------------------------------------
void
calc(void) {
  for (int ix = 1; ix < L - 1; ix++) {
    for (int iy = 1; iy < L - 1; iy++) {
      double du = 0;
      double dv = 0;
      du = Du*laplacian(ix,iy,u);
      dv = Dv*laplacian(ix,iy,v);
      /*
      du += Du * u[ix - 1][iy];
      dv += Dv * v[ix - 1][iy];
      du += Du * u[ix + 1][iy];
      dv += Dv * v[ix + 1][iy];
      du += Du * u[ix][iy - 1];
      dv += Dv * v[ix][iy - 1];
      du += Du * u[ix][iy + 1];
      dv += Dv * v[ix][iy + 1];
      du -= Du * u[ix][iy] * 4.0;
      dv -= Dv * v[ix][iy] * 4.0;
      */
      du += calcU(u[ix][iy], v[ix][iy]);
      dv += calcV(u[ix][iy], v[ix][iy]);
      u[ix][iy] += du * dt;
      v[ix][iy] += dv * dt;
    }
  }
}
//----------------------------------------------------------------------
void
save_as_vtk(void) {
  static int index = 0;
  char filename[256];
  sprintf(filename, "conf%03d.vtk", index);
  std::cerr << filename << std::endl;
  index++;
  FILE *fp = fopen(filename, "w");
  fprintf(fp, "# vtk DataFile Version 1.0\n");
  fprintf(fp, "conf000.vtk\n");
  fprintf(fp, "ASCII\n");
  fprintf(fp, "DATASET UNSTRUCTURED_GRID\n");
  fprintf(fp, "POINTS %d float\n", L * L);
  for (int i = 0; i < L; i++) {
    for (int j = 0; j < L; j++) {
      fprintf(fp, "%d %d 0\n", i, j);
    }
  }

  fprintf(fp, "CELLS %d %d\n", L * L, L * L * 2);
  for (int i = 0; i < L * L; i++) {
    fprintf(fp, "1 %d\n", i);
  }

  fprintf(fp, "CELL_TYPES %d\n", L * L);
  for (int i = 0; i < L * L; i++) {
    fprintf(fp, "1\n");
  }

  fprintf(fp, "POINT_DATA %d\n", L * L);
  fprintf(fp, "SCALARS scalars float\n");
  fprintf(fp, "LOOKUP_TABLE default\n");
  for (int i = 0; i < L; i++) {
    for (int j = 0; j < L; j++) {
      fprintf(fp, "%f\n", u[i][j]);
    }
  }
  fclose(fp);
}
//----------------------------------------------------------------------
int
main(void) {
  init();
  for (int i = 0; i < 20000; i++) {
    calc();
    if (i % 100 == 0) {
      save_as_vtk();
    }
  }
}
//----------------------------------------------------------------------
