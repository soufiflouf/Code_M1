#include "Sym_Mat.hpp"

Sym_Mat::Sym_Mat(int n, double value): Abstract_Mat(n){
    n_size = n;
    values = new double[n*(n+1)/2];
    for (int ii = 0; ii<n*(n+1)/2; ii++){
            values[ii] = value;
    }
}

double& Sym_Mat::operator()(int i, int j) const{
if (i < j){
    return values[j*(j+1)/2+i];
} else {
    return values[i*(i+1)/2+j];
}
}

Sym_Mat::Sym_Mat(Sym_Mat const & MM): Abstract_Mat(MM.nsize()){
    int n = MM.nsize();
    n == 0? values = nullptr : values = new double[n*(n+1)/2];
    n_size = n;
    for (int ii = 0; ii<n; ii++){
        for (int jj = 0; jj<= ii; jj++){
            values[ii*(ii+1)/2+jj] = MM(ii,jj);
        }
    }
}

Sym_Mat& Sym_Mat::operator=(const Sym_Mat& MM){
        if (this != &MM){
        delete[] values;
        int n = MM.nsize();
        values = new double[n_size=n*(n+1)/2];
        for (int ii = 0; ii<n_size; ii++){
            for (int jj = 0; jj<= ii; jj++){
                values[ii*(ii+1)/2+jj] = MM(ii,jj);
            }
        }
    }
    return *this;
}

Sym_Mat::~Sym_Mat(){
    delete[] values;
}

Vector Sym_Mat::operator*(const Vector& v) const{
    Vector tmp(n_size);
    if (v.size()!=n_size){
        cerr << "Error in operator*: vector and matrix are not compatible." <<endl;
        exit(0);
    } else {
        for (int ii = 0; ii < n_size; ++ii){
            for (int jj = 0; jj < n_size; ++jj){
                if (ii < jj){
                    tmp[ii] += values[jj*(jj+1)/2+ii] *v[jj];
                } else {
                    tmp[ii] += values[ii*(ii+1)/2+jj] *v[jj];
                }
            }
        }
    }
    return tmp;
}

