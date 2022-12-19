#pragma once
#include "Abstract_Mat.hpp"
#include "Vector.hpp"

class COO_Mat : public Abstract_Mat
{
public:

COO_Mat(int size, int nb_non_zero);
~COO_Mat();

Vector operator*(const Vector&) const;  // matrix-vector multiply

double& operator[](int i) const { return values[i]; }  // subscripting
int& get_coord_i(int i) const { return coord_i[i]; }    // 1st nonzero entry ofeach row
int& get_coord_j(int i) const { return coord_j[i]; }
//int CG(Vector& x, const Vector& b, double& eps, int& iter);


private:

double* values;
int* coord_i;
int* coord_j;

int number_non_zero;

};
