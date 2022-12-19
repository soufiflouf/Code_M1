#pragma once
#include "Vector.hpp"

class Abstract_Mat
{               // base matrix, an abstract class
protected:

  int n_rows;
  int n_cols;

public:

  Abstract_Mat(int size)
  {
    n_rows = size;
    n_cols = size;
  };

  virtual Vector operator*(const Vector&) const=0;
  int nrows(){return n_rows;};
  int ncols(){return n_cols;};

  int Conjugate_Gradient(Vector& x, const Vector& b, double& eps, int& iter);
  virtual ~Abstract_Mat(){};

};
