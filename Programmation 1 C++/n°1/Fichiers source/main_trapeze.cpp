#include <math.h>
#include <iostream>

#include "trapezoidal.hpp"

double square(double d) { return d*d; }

using namespace std;

int main()
{

  double result = trapezoidal(0., 5., square, 100);
  cout << "Integral using trapezoidal with n = 100 is: " << result << '\n';

  result = trapezoidal(0., 5., sqrt, 100);
  cout << "Integral using trapezoidal with n =100 is: " << result << '\n';

}
