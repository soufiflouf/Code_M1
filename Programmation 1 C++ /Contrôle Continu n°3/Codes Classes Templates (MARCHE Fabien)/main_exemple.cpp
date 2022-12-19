#include <iostream>
#include "Vector.hpp"
#include "Full_Mat.hpp"
#include "Abstract_Mat.hpp"
#include "COO_mat.hpp"

using namespace std;


int main()
{

  int n = 20, m = 20;

	// dense Full_Mat initialisation
  Full_Mat<double> mat1(n,m);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
        mat1[i][j] =  n/(abs(i - j) + 1.0);
    }
  }

  COO_Mat<double> mat2(n, n*m);

  int compteur = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {

        mat2[compteur] =  n/(abs(i - j) + 1.0);
        mat2.get_coord_i(compteur) = i;
        mat2.get_coord_j(compteur) = j;
        ++compteur;
    }
  }



  Vector<double> vec1(n) ;
  for (int i = 0; i < n; i++) vec1[i] = i;

  int iter = 200;
  double eps = 1.0e-14;

  Vector<double> res(vec1.size());

  Abstract_Mat<double>* ptm = &mat1;

  int retour = ptm->Conjugate_Gradient(res, vec1, eps, iter);

  if (retour == 0) cout << "CG returned successfully\n";
  //cout << "true solutionn is: " << vec1 << "   ";

  cout << iter << " iterations used. " << "\n";
  cout << "Residual in CG= " << eps << " \n " ;

  cout << "le vecteur résultat est: " << endl;
  cout << "  " << endl;
  cout << res << endl;

  cout << "le produit de mat1 par res est: " << endl;
  cout << " " << endl;
  cout << mat1*res << endl;

  //cout << "error in CG= " << (vec2-vec1).maxnorm() << "\n" ;

  cout <<  "\n";

  ptm = &mat2;

  retour = ptm->Conjugate_Gradient(res, vec1, eps, iter);

  if (retour == 0) cout << "CG returned successfully\n";
  //cout << "true solutionn is: " << vec1 << "   ";

  cout << iter << " iterations used. " << "\n";
  cout << "Residual in CG= " << eps << " \n " ;

  cout << "le vecteur résultat est: " << endl;
  cout << "  " << endl;
  cout << res << endl;

  cout << "le produit de mat2 par res est: " << endl;
  cout << " " << endl;
  cout << mat2*res << endl;

  //cout << "error in CG= " << (vec2-vec1).maxnorm() << "\n" ;

  cout <<  "\n";

}
