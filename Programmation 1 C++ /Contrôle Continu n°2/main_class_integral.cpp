#include <math.h>
#include <iostream>
#include "class_definite_integral.hpp"
using namespace std;

double square(double d) { return d*d; }

int main()
{
  int n;
  cout << "Veuiller entrer un nombre de sous-intervalles: "<<endl;
  cin >> n;
  cout << endl;
  // Si on teste avec n=100, a=0, b=5 et avec les mêmes fonctions du CC1 à savoir: square et sqrt, on retrouve les mêmes valeurs d'approximation
  
  cout << "- Partie fonction carrée: " << endl;
  definite_integral fctsquare(5.,-2.,square); 
  cout << "L'attribut lower est initialisé par le constructeur à: " << fctsquare.lowbd() << endl; 
  cout << "L'attribut upper est initialisé par le constructeur à: " << fctsquare.upbd() << endl;  
  fctsquare.change_bounds(0.,5.); 
  cout << "L'attribut lower vaut maintenant (après appel du manipulateur): " << fctsquare.lowbd() << endl;
  cout << "L'attribut upper vaut maintenant (après appel du manipulateur): " << fctsquare.upbd() << endl;
  cout << "L'approximation de l'intégrale de " << fctsquare.lowbd() << " à " << fctsquare.upbd() << " de la fonction carrée par la méthode des trapèzes vaut: " <<fctsquare.trapezoidal(n) << endl; 
  cout << endl;

  cout << "- Partie fonction racine: " << endl;
  definite_integral fctraci(0.,0.,sqrt);
  cout << "L'attribut lower est initialisé par le constructeur à: " << fctraci.lowbd() << endl; 
  cout << "L'attribut upper est initialisé par le constructeur à: " << fctraci.upbd() << endl; 
  fctraci.change_bounds(0.,5.); 
  cout << "L'attribut lower vaut maintenant (après appel du manipulateur): " << fctraci.lowbd() << endl;
  cout << "L'attribut upper vaut maintenant (après appel du manipulateur): " << fctraci.upbd() << endl;
  cout << "L'approximation de l'intégrale de " << fctraci.lowbd() << " à " << fctraci.upbd() << " de la fonction racine par la méthode des trapèzes vaut: " << fctraci.trapezoidal(n) << endl; 
  cout << endl;

  cout << "Au revoir. " << endl;
}

// Commande de compilation:
// g++ main_class_integral.cpp class_definite_integral.cpp -o main_class_integral
// ./main_class_integral