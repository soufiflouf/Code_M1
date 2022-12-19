#pragma once

class FullMtx {
  double** mx;

public:
  FullMtx(int n);

  int dimn;

  double& operator()(int i, int j);

};
