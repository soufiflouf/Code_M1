#pragma once
#include "Abstract_Mat.hpp"
#include "Vector.hpp"
#include <iostream>
#include <cmath>


// declaration
template<typename T>
class Full_Mat : public Abstract_Mat<T>
{
public:

Full_Mat(int size, double value=0.);
Full_Mat(Full_Mat<T> const &);

Full_Mat<T>& operator=(const Full_Mat<T>&);
T* operator[](int i) const { return values[i]; };

template<typename S>
friend ostream& operator<<(ostream&, const Full_Mat<S>&);

~Full_Mat();


          // overload =
Vector<T> operator*(const Vector<T>&) const;  // matrix-vector multiply

private:

// int n_rows;
// int n_cols;
T** values;

};


// definition

template<typename T>
Full_Mat<T>::Full_Mat(int size, double value):Abstract_Mat<T>(size){

  // dynamic memory allocation of an
  // array of dimension 2
  int n_cols = this->n_cols;
  int n_rows = this->n_rows;

  values = new double*[n_cols];
  for(int ii=0; ii<n_cols; ++ii){
    values[ii] = new double[n_rows];
  }

  // fill-in the matrix with value:
  // all coeffs have the same value
  for(int i_row=0; i_row<n_rows; ++i_row){
    for(int i_col=0; i_col<n_cols; ++i_col){
      values[i_row][i_col] = value;
    }
  }

}

template<typename T>
Full_Mat<T>::Full_Mat(Full_Mat<T> const & AA)
{

  int n_cols = this->n_cols;
  int n_rows = this->n_rows;

  if(AA.values==0)
  {
    values = nullptr;
  }
  else
  {
      n_rows = AA.n_rows;
      n_cols = AA.n_cols;

      // "ne fonctionne pas"
      //values = AA.values;
      values = new double*[n_cols];
      for(int ii=0; ii<n_cols; ++ii){
        values[ii] = new double[n_rows];
      }

      // fill-in the matrix with value:
      // all coeffs have the same value
      for(int i_row=0; i_row<n_rows; ++i_row){
        for(int i_col=0; i_col<n_cols; ++i_col){
          values[i_row][i_col] = AA.values[i_row][i_col];
        }
      }
  }
}

template<typename T>
Full_Mat<T>& Full_Mat<T>::operator=(const Full_Mat<T>& AA)
{
  int n_cols = this->n_cols;
  int n_rows = this->n_rows;

  if(&AA == this)
  {
    return *this;
  }
  else
  {
    for(int ii=0; ii<n_cols; ++ii){
      delete [] values[ii];
    }
    delete [] values;

      n_rows = AA.n_rows;
      n_cols = AA.n_cols;

      // "ne fonctionne pas"
      //values = AA.values;
      values = new double*[n_cols];
      for(int ii=0; ii<n_cols; ++ii){
        values[ii] = new double[n_rows];
      }

      // fill-in the matrix with value:
      // all coeffs have the same value
      for(int i_row=0; i_row<n_rows; ++i_row){
        for(int i_col=0; i_col<n_cols; ++i_col){
          values[i_row][i_col] = AA.values[i_row][i_col];
        }
      }
      return *this;
  }

}

template<typename S>
ostream& operator<<(ostream& s, const Full_Mat<S>& mat) {
  for (int i =0; i< mat.n_rows; i++) {
    s << "\n" << i << "-th row:    \n";
    for (int j =0; j< mat.n_cols; j++) {
      s << mat.values[i][j] << "  ";
      if (j%10 ==9) s << "\n";
    }
    s << "\n";
  }
  return s;
}

template<typename T>
Vector<T> Full_Mat<T>::operator*(const Vector<T>& vv) const
{
  int n_cols = this->n_cols;
  int n_rows = this->n_rows;

    if(vv.size() == n_cols)
    {
        Vector<T> result(n_rows);

        for(int i_rows=0; i_rows<n_rows; ++i_rows){
          for(int i_cols=0; i_cols<n_cols; ++i_cols){
            result[i_rows] += values[i_rows][i_cols]*vv[i_cols];
          }
        }
        return result;
    }
    else
    {
      cout <<"Operator*: bad matrix/vector sizes" << endl;
      exit(0);
    }
}

template<typename T>
Full_Mat<T>::~Full_Mat(){

  int n_cols = this->n_cols;
  int n_rows = this->n_rows;

  for(int ii=0; ii<n_cols; ++ii){
    delete [] values[ii];
  }
  delete [] values;
}
