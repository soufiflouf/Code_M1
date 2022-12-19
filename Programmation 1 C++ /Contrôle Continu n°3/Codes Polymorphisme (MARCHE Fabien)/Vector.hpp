#pragma once 
#include <iostream>
#include <cassert>

using namespace std;

class Vector
{
 private:

  double* M_data;
  int M_size;

 public:

  Vector(int size, double value=0); // constructeur 2

  ~Vector();

  void affiche();

  // copy constructor
  Vector(Vector const & v);
  //
  // assignment operator
  Vector& operator=(Vector const &v);
  //
  // subscript operator lvalue
  double& operator[](int i);

  // subscript operator const
  double operator[](int i) const{
	  return M_data[i];
  }

  int size() const;

  // // overload de <<
  friend std::ostream& operator << (std::ostream&, const Vector&);
  //

  friend Vector operator+(const Vector&);               // unary operator, v = +v2
  friend Vector operator-(const Vector&);               // unary operator, v = -v2


  friend Vector operator+(const Vector&, const Vector&);  // v= v1 + v2
  friend Vector operator-(const Vector&, const Vector&);  // v= v1 - v2

  friend Vector operator*(double, const Vector&);            // scalar-vec multiply
  friend Vector operator*(const Vector&, double);            // vec-scalar multiply
  //
  friend double dot(const Vector&, const Vector&);

  double maxnorm() const;                             // maximum norm
  double twonorm() const;

  Vector& operator+=(const Vector& vec); // add-assigment v += v2
  Vector& operator-=(const Vector& vec); // diff-assigment v -=v2


};
