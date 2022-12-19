#include <iostream>
#include <vector>
#include <cmath>
#include "lagrange.hpp"

using namespace std;

int main(){
float x_in(1.4);
int n(4);
float* xpts;
xpts=new float[n];
for (int j=0;j<=n-1;++j){
    xpts[j]=1+(j/4.0);
}

float* ypts;
ypts=new float[n];
for (int j=0;j<=n-1;++j){
    ypts[j]=exp(xpts[j]);
}

cout << lagrange(xpts, ypts, x_in, n-1) << endl;
}

//Commande de compilation:
// g++ main_lagrange.cpp -o main_lagrange
// ./main_lagrange