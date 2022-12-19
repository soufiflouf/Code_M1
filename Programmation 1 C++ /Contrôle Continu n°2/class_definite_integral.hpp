typedef double (*pfn) (double);

class definite_integral {

  double lower;
  double upper;
  pfn integrand;


public:

  definite_integral(double a, double b, pfn f); // constructor
  double lowbd() const; // accessor: get lower bound
  double upbd() const; // accessor: get upper bound
  void change_bounds(double a, double b); //change integral bounds to a, b
  double trapezoidal(int n) const; // compute integral using trapezoidal rule
     // with n sub-intervals

};