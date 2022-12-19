#include <iostream>
#include <cmath>

#include "Full_Mat.hpp"

using namespace std;

Full_Mat::Full_Mat(int size, double value):Abstract_Mat(size){

  // dynamic memory allocation of an
  // array of dimension 2

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

Full_Mat::Full_Mat(Full_Mat const & AA):Abstract_Mat(AA.n_rows)
{
  if(AA.values==0)
  {
    values = nullptr;
  }
  else
  {
      //n_rows = AA.n_rows;
      //n_cols = AA.n_cols;

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

Full_Mat& Full_Mat::operator=(const Full_Mat& AA)
{
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

ostream& operator<<(ostream& s, const Full_Mat& mat) {
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

Vector Full_Mat::operator*(const Vector& vv) const
{
    if(vv.size() == n_cols)
    {
        Vector result(n_rows);

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


Full_Mat::~Full_Mat(){

  for(int ii=0; ii<n_cols; ++ii){
    delete [] values[ii];
  }
  delete [] values;
}
