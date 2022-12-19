#include "COO_mat.hpp"

COO_Mat::COO_Mat(int size, int nb_non_zero):Abstract_Mat(size), number_non_zero(nb_non_zero){

  // dynamic memory allocation of an
  // array of dimension 2
  //number_non_zero = nb_non_zero;

  values  = new double[nb_non_zero];
  coord_i = new int[nb_non_zero];
  coord_j = new int[nb_non_zero];

}

COO_Mat::~COO_Mat()
{
  delete [] values;
  delete [] coord_i;
  delete [] coord_j;
}

Vector COO_Mat::operator*(const Vector& vv) const
{

  if(vv.size() == n_cols)
  {
      Vector result(n_rows);

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
