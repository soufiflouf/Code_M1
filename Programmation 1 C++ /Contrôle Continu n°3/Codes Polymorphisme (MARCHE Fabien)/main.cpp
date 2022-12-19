#include <iostream>
#include "Vector.hpp"
#include "Sym_Mat.hpp"
#include "Abstract_Mat.hpp"

using namespace std;

int main()
{
    int n = 3;
    Sym_Mat Mat1(n);

    for (int ii = 0; ii<n; ii++){
            if (ii > 0){
                for (int jj = ii-1; jj <=ii; jj++){
                    Mat1(ii,jj) = 1; // You only need to change 1 side, the other automatically gets changed.
            }
            } else {
                Mat1(0,0) = 5;
            }
    }

    cout << Mat1(0,0) << endl;
    cout << Mat1(0,1) << endl;
    cout << Mat1(0,2) << endl;
    cout << Mat1(1,0) << endl;
    cout << Mat1(1,1) << endl;
    cout << Mat1(1,2) << endl;
    cout << Mat1(2,0) << endl;
    cout << Mat1(2,1) << endl;
    cout << Mat1(2,2) << endl;

    /* Vector v1(n,1);

    Vector resprod = Mat1*v1;

    cout << resprod << endl;// CHECK

    Vector v2(n);
    for (int i = 0; i<n;i++) v2[i] = i;

    int iter = 200;
    double eps = 1.0e-14;
    Vector res(v2.size());

    Abstract_Mat* ptm = &Mat1;

    int ret = ptm->Conjugate_Gradient(res, v2, eps, iter);

    if (ret == 0) cout << "CG returned succesfully" << endl; */

}
