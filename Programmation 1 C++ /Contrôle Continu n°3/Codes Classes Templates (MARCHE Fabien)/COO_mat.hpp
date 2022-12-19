#pragma once
#include "Abstract_Mat.hpp"
#include "Vector.hpp"

// declaration
template<typename T>
class COO_Mat : public Abstract_Mat<T>
{
public:

COO_Mat(int size, int nb_non_zero);
~COO_Mat();

Vector<T> operator*(const Vector<T>&) const;  // matrix-vector multiply

T& operator[](int i) const { return values[i]; }  // subscripting
int& get_coord_i(int i) const { return coord_i[i]; }    // 1st nonzero entry ofeach row
int& get_coord_j(int i) const { return coord_j[i]; }
//int CG(Vector& x, const Vector& b, double& eps, int& iter);


private:

T* values;
int* coord_i;
int* coord_j;

int number_non_zero;

};


// definition
template<typename T>
COO_Mat<T>::COO_Mat(int size, int nb_non_zero):Abstract_Mat<T>(size), number_non_zero(nb_non_zero){

  // int n_cols = this->n_cols;
  // int n_rows = this->n_rows;

  // dynamic memory allocation of an
  // array of dimension 2
  //number_non_zero = nb_non_zero;

  values  = new double[nb_non_zero];
  coord_i = new int[nb_non_zero];
  coord_j = new int[nb_non_zero];

}

template<typename T>
COO_Mat<T>::~COO_Mat()
{
  delete [] values;
  delete [] coord_i;
  delete [] coord_j;
}

template<typename T>
Vector<T> COO_Mat<T>::operator*(const Vector<T>& vv) const
{

  int n_cols = this->n_cols;
  int n_rows = this->n_rows;
  
  if(vv.size() == n_cols)
  {
      Vector<T> result(n_rows);

      for(int i_coeff=0; i_coeff<number_non_zero; ++i_coeff){
        int i_rows = coord_i[i_coeff];
        int i_cols = coord_j[i_coeff];

        result[i_rows] += values[i_coeff]*vv[i_cols];
      }

      return result;
  }
  else
  {
    cout <<"Operator*: bad matrix/vector sizes" << endl;
    exit(0);
  }

}
