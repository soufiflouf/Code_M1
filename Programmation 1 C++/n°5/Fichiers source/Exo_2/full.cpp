#include "full.hpp"


FullMtx::FullMtx(int n) {
    dimn = n;
    mx = new double* [dimn];
    for (int i=0; i<dimn; i++) mx[i] = new double [dimn];
    for (int i=0; i<dimn; i++)
      for (int j=0; j<dimn; j++)
        mx[i][j] = 0;              // initialization
  }


double& FullMtx::operator()(int i, int j) { return mx[i][j]; }
