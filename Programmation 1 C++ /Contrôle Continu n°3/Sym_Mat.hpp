#pragma once
#include "Vector.hpp"
#include "Abstract_Mat.hpp"

class Vector;

using namespace std;

class Sym_Mat : public Abstract_Mat{
    public:

Sym_Mat(int n, double value = 0.);

double& operator()(int i, int j) const;

int nsize() const{return n_size;}

Sym_Mat(Sym_Mat const & MM);
Sym_Mat& operator=(const Sym_Mat& MM);
~Sym_Mat();

Vector operator*(const Vector&) const;

private:
int n_size;
double* values;
};
