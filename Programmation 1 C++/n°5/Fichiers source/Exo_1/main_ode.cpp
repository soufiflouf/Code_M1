#include "ode.hpp"
#include <iostream>

using nammespace std;

double f(double t, double x) {
  return x*(1 - exp(t))/(1 + exp(t));
}

int main()
{

  ode exmp(O., 3., 2., f); // x(O) = 3, T =2
  double* soln =exmp.euler(100); // 100 subintervals

  cout << "La valeur approchée de x a l'instant T est: "<< soln[99] << endl;
}
