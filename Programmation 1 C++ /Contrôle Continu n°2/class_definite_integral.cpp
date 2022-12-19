#include <iostream>
#include <cmath>
#include <vector>
#include "class_definite_integral.hpp"
using namespace std;

definite_integral::definite_integral(double a, double b, pfn f): lower(a),upper(b),integrand(f){
}

double definite_integral::lowbd() const{return lower;}
double definite_integral::upbd() const{return upper;}

void definite_integral::change_bounds(double a, double b){
    lower=a;upper=b;
}

double definite_integral::trapezoidal(int n) const{ //je reprends ici la même définition utilisée lors de mon CC1

    //Déclaration d'un vecteur de taille n+1 qui contient tous les points de discrétisation
    vector<double> pts(n+1);
    pts[0]=0;
    double pas= (upper-lower)*(1./n);
    for (int i(1);i<=n-1;++i){
        pts[i]=pts[i-1]+pas;
    }
    pts[n]=upper;

   //Déclaration d'un vecteur qui contient les évaluations de la fonction f en chacun des points
   vector<double> evf(n+1);
   evf[0]=integrand(pts[0]);
   for (int i(1);i<=n-1;++i){
        evf[i]=evf[i-1]+pas;
   }
   evf[n]=integrand(pts[n]);

   //Approximation de l'intégrale
   vector<double> appro(n);
   appro[0]=(integrand(pts[0])+integrand(pts[1]))*(pas/2);
   double sum=0;
   for (int i(1);i<=n-1;++i){
       appro[i]=(integrand(pts[i])+integrand(pts[i+1]))*(pas/2);
       sum=sum+appro[i];
   }
   return sum;
}