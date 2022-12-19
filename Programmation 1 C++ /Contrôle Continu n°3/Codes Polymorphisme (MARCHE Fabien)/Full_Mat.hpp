#pragma once
#include "Abstract_Mat.hpp"
#include "Vector.hpp"

class Full_Mat : public Abstract_Mat
{
public:

Full_Mat(int size, double value=0.);
Full_Mat(Full_Mat const &);
Full_Mat& operator=(const Full_Mat&);
double* operator[](int i) const { return values[i]; };
friend ostream& operator<<(ostream&, const Full_Mat&);

~Full_Mat();


          // overload =
Vector operator*(const Vector&) const;  // matrix-vector multiply

private:

// int n_rows;
// int n_cols;
double** values;

};
