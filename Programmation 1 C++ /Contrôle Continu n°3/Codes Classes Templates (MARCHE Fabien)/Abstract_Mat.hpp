#pragma once
#include "Vector.hpp"


// declaration
template<typename T>
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


  virtual Vector<T> operator*(const Vector<T>&) const=0;

  int nrows(){return n_rows;};
  int ncols(){return n_cols;};

  int Conjugate_Gradient(Vector<T>& x, const Vector<T>& b, double& eps, int& iter);

  virtual ~Abstract_Mat(){};
};


// definition

template<typename T>
int Abstract_Mat<T>::Conjugate_Gradient(Vector<T>& x, const Vector<T>& b, double& eps,
	                       int& iter) {
// Conjugate gradient method.
// x: on entry, initial guess; on retrun: approximate solution
// b: right hand side vector as in A x = b;
// eps:  on entry, tolerance; on retrun: absolute residual in Euclid norm
// iter: on entry, max number of iterations allowed;
//       on return, actual number of iterations used

  if (n_rows != b.size()){
    cout << "Conjugate_Gradient: matrix and vector sizes do not match" << endl;
  }

  const int maxiter = iter;
  Vector<T> r = b - (*this)*x;                   // initial residual
  //Vector z = preconding(r,prec);              // solve the precond system
  Vector<T> z = r;
  Vector<T> p = z;                               // p: search direction
  T zr = dot(z,r);                            // inner prod of z and r
  const T stp = eps*b.twonorm();         // stopping criterion

  if (r.maxnorm() == 0.0) {                   // if intial guess is true soln,
    eps = 0.0;                                // return. Otherwise division by
    iter = 0;                                 // zero would occur.
    return 0;
  }

  for (iter = 0; iter < maxiter; iter++) {     // main loop of CG method
    Vector<T> mp = (*this)*p;                     // one matrix-vector multiply
    T pap = dot(mp,p);                         // one of two inner products
    T alpha = zr/pap;                          // pap is 0 only when r is 0
    x += alpha*p;                              // update the iterative soln
    r -= alpha*mp;                             // update residual
    if (r.twonorm() <= stp) break;             // stop if convergence achieved
    //z = preconding(r,prec);                    // preconditioning
	  z=r;
    T zrold = zr;
    zr = dot(z,r);                             // another of two inner products
    T beta= zr/zrold;                          // zrold = 0 only when r is 0
    p = z + beta*p;                            // update search direction
  }

  eps = r.twonorm();
  if (iter == maxiter) return 1;
  else return 0;
} // end CG()
