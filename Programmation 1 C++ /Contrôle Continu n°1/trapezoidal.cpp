#include <math.h>
#include <iostream>
#include <vector>
#include "trapezoidal.hpp" 

using namespace std;

double trapezoidal(double a, double b, pfn f, double n){  
    
    //Déclaration d'un vecteur de taille n+1 qui contient tous les points de discrétisation
    vector<double> pts(n+1);
    pts[0]=0;
    double pas= (b-a)*(1/n);
    for (int i(1);i<=n-1;++i){
        pts[i]=pts[i-1]+pas;
    }
    pts[n]=b;

   //Déclaration d'un vecteur qui contient les évaluations de la fonction f en chacun des points
   vector<double> evf(n+1);
   evf[0]=f(pts[0]);
   for (int i(1);i<=n-1;++i){
        evf[i]=evf[i-1]+pas;
   }
   evf[n]=f(pts[n]);

   //Approximation de l'intégrale
   vector<double> appro(n);
   appro[0]=(f(pts[0])+f(pts[1]))*(pas/2);
   double sum=0;
   for (int i(1);i<=n-1;++i){
       appro[i]=(f(pts[i])+f(pts[i+1]))*(pas/2);
       sum=sum+appro[i];
   }
   return sum;
}
