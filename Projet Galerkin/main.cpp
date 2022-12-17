#include <iostream>
#include <cmath>
#include "full.hpp"

using namespace std;

int main(){

    int N;
    double eta;

    cout<<"Entrer le nombre de points de discretisation voulus :"<<endl;
    cin>>N;
    N=N-2;

    double h=1./(N+1);

    cout<<"Entrer le coefficient de penalisation voulu :"<<endl;
    cin>>eta;

    FullMtx A(N*2);

    double moyenne_phi1 = 0;
    double moyenne_phiprime1 = 1/h;
    double moyenne_phi2 = 1;
    double moyenne_phiprime2 = 0;

    double saut_phi1 = -1;
    double saut_phiprime1 = 0;
    double saut_phi2 = 0;
    double saut_phiprime2 = 0;

    double A11 = N*saut_phiprime1*moyenne_phi1-N*saut_phi1*moyenne_phiprime1+N*(eta/h)*saut_phi1*saut_phi1;

    double trois_sommes12 = N*saut_phiprime1*moyenne_phi2-N*saut_phi1*moyenne_phiprime2+N*(eta/h)*saut_phi1*saut_phi2;
    double A12 = trois_sommes12-1/(pow(h,2));

    double trois_sommes21 = N*saut_phiprime2*moyenne_phi1-N*saut_phi2*moyenne_phiprime1+N*(eta/h)*saut_phi2*saut_phi1;

    double trois_sommes22 = N*saut_phiprime2*moyenne_phi2-N*saut_phi2*moyenne_phiprime2+N*(eta/h)*saut_phi2*saut_phi2;

    

    for (int ii=0; ii<2*N; ii++){
        for (int jj=0; jj<2*N; jj++){
            if (ii%2 == 0){
                if (jj%2 == 0){
                    A(ii,jj) = A11;
                }
                else {
                    if ((jj-1) == ii){
                        A(ii,jj) = A12; 
                    }
                    else {
                        A(ii,jj) = trois_sommes12;
                    }
                }
            }
            else { 
                if (jj%2 == 0){
                    A(ii,jj) = trois_sommes21;
                }
                else {
                    A(ii,jj) = trois_sommes22;
                }
            }
        }
    }

    cout<<"La matrice de discretisation Ah vaut :"<<endl;

    for (int ii=0; ii<2*N; ii++){
        for (int jj=0; jj<2*N; jj++){
            cout<<A(ii,jj)<<"   ";
        }
        cout<<endl;
    }
}