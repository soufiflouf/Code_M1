#pragma once
#include <iostream>
#include <cmath>
#include <vector>

using namespace std;

template<typename T> 
T lagrange(T* vx, T* vy, T x_in, const int n){
    T yp;
    for(int i=0;i<n+1;i++)
	 {
		  T p=1;
		  for(int j=0;j<n+1;j++)
		  {
			   if(i!=j)
			   {
			    	p = p* (x_in - vx[j])/(vx[i] - vx[j]);
			   }
		  }
		  yp+= p * vy[i];
	 }
return yp;
}