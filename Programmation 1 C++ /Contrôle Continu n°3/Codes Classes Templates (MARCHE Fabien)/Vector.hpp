
#pragma once

#include <iostream>
#include <cassert>
#include <cmath>

using namespace std;

template<typename T>
class Vector
{
 private:

  T* M_data;
  int M_size;


 public:

  Vector(); //default constructor
  //Vector(int i); // constructeur 1
  Vector(int i, T v=0); // constructeur 2
  //Vector(initializer_list<T> lst); // constructeur 3
	  //
// copy constructor
  Vector(Vector<T> const &v);
	  //
	  // // assignment operator : une dernière implémentation
  Vector<T>& operator=(Vector<T> const &v);
  Vector<T>& operator+=(const Vector<T>& vec);
	Vector<T>& operator-=(const Vector<T>& vec);
	  //
	  // subscript operator lvalue
	  T& operator[](int i){
	  	  return M_data[i];
	  }

	  // subscript operator const
	  T operator[](int i) const{
	  	  return M_data[i];
	  }
	  //
	  // // //move constructor
	  // // Vector(Vector&& v);
	  // //
	  // // // move assignment operator
	  // // Vector& operator=(Vector&& v);
	  //
	  // overload de <<
	  template <typename S>
	  friend std::ostream& operator << (std::ostream&, const Vector<S>&);

	   ~Vector();
	  //
	  int size() const { return M_size; }             // return size of vector
	  T maxnorm() const;                             // maximum norm
	  T twonorm() const;                             // L-2 norm
	  //
	  template <typename S>
	  friend Vector<S> operator+(const Vector<S>&);               // unary operator, v = + v2

	  template <typename S>
	  friend Vector<S> operator-(const Vector<S>&);               // unary operator, v = - v2

	  //
	  template <typename S>
	  friend Vector<S> operator+(const Vector<S>&, const Vector<S>&);  // v= v1 + v2

	  template <typename S>
	  friend Vector<S> operator-(const Vector<S>&, const Vector<S>&);  // v= v1 - v2
	  //
	  template <typename S>
	  friend Vector<S> operator*(S, const Vector<S>&);            // vec-scalar multiply

	  template <typename S>
	  friend Vector<S> operator*(const Vector<S>&, S);            // vec-scalar multiply

	  template <typename S>
	  friend S dot(const Vector<S>&, const Vector<S>&);           // dot product
};



// class Vector implementation

template<typename T>
Vector<T>::Vector(){
	M_data = nullptr;
	M_size = 0;
	//////cout << "Default const: allocation du vecteur"<<M_data<<"\n";
}

// template<typename T>
// Vector<T>::Vector(int i){
// 	M_data = new T[M_size=i];
// 	////cout << "Const 1: allocation du vecteur"<<M_data<<"\n";
// }; // constructeur 1
//
template<typename T>
Vector<T>::Vector(int i, T v){ //constructeur 2
	M_data = new T[M_size=i];
	////cout << "Const 2: allocation du vecteur"<<M_data<<"\n";
    for(int k=0;k<M_size;++k)M_data[k]=v;
}
//
// template<typename T>
// Vector<T>::Vector(initializer_list<T> lst){
// 	M_data = new T[lst.size()];
// 	M_size = static_cast<int>(lst.size());
// 	////cout << "Const 3: allocation du vecteur"<<M_data<<"\n";
//  	std::copy(lst.begin(), lst.end(), M_data);
// }
//
template<typename T>
Vector<T>::~Vector(){
	////cout << "Destruction du vecteur"<<M_data<<"\n";
	delete[] M_data;
}


  // copy constructor
template<typename T>
Vector<T>::Vector(Vector const &v){
	v.M_size==0? M_data = nullptr : M_data = new T[v.M_size];
	M_size = v.M_size;
	////cout << "Copy constructor: allocation du vecteur"<<M_data<<" de taille "<<M_size<<"\n";
	for (int k=0;k<M_size;++k)M_data[k] = v.M_data[k];
}

// Assigment operator : une dernière implémentation

template<typename T>
Vector<T>& Vector<T>::operator=(Vector<T> const &v){
  if (this != &v){
	  delete[] M_data;
	  M_data = new T[M_size=v.M_size];
	  ////cout << "Assign du vecteur"<<v.M_data<<"\n";
	  for(int k=0;k<M_size;++k) M_data[k]=v.M_data[k];
  }
  return *this;
}
//
// //move constructor
// // Vector::Vector(Vector&& v){
// // 	M_data=v.M_data;
// // 	M_size=v.M_size;
// // 	////cout << "Move du vecteur"<<v.M_data<<" via move constructeur"<<"\n";
// // 	v.M_size = 0;
// // 	v.M_data = nullptr;
// //
// // }
// //
// // // move assignment operator
// // Vector& Vector::operator=(Vector&& v){
// // 	////cout << "Move du vecteur"<<v.M_data<<" via move assignment"<<"\n";
// // 	delete[] M_data;
// // 	M_data = v.M_data;
// // 	M_size = v.M_size;
// //
// // 	v.M_data = nullptr;
// // 	v.M_size = 0;
// // 	return *this;
// // }
//
// surcharge opérateur de sortie
template<typename T>
std::ostream& operator << (std::ostream& s, const Vector<T>& v){
  using std::endl;
  s << "Surcharge opérateur: taille du vecteur: " << v.M_size << endl;
  for (int i = 0; i < v.M_size; i++){
    s << i+1 << " " << v.M_data[i] << endl;
  }
  return s;
}
//
//
template <typename T>
Vector<T> operator+(const Vector<T>& vec) {             // usage: vec1 = + vec2;
  return vec;
}

template <typename T>
Vector<T> operator-(const Vector<T>& vec) {             // usage: vec1 = - vec2;
  Vector<T> minus = vec;
  for (int i = 0; i < vec.M_size; i++) minus[i] = - vec[i];
  return minus;
}
//
template<typename T>
Vector<T>& Vector<T>::operator+=(const Vector<T>& vec) {
  //if (M_size != vec.M_size) error("bad vector sizes in Vcr::operator+=()");
  for (int i = 0; i < M_size; i++) M_data[i] += vec.M_data[i];
  return *this;
}

template<typename T>
Vector<T>& Vector<T>::operator-=(const Vector<T>& vec) {
  //if (M_size != vec.M_size) error("bad vector sizes in Vcr::operator-=()");
  for (int i = 0; i < M_size; i++) M_data[i] -= vec.M_data[i];
  return *this;
}
//
template<typename T>
Vector<T> operator+(const Vector<T>& v1, const Vector<T>& v2) {         // v=v1+v2
  //if (v1.M_size != v2.M_size ) error("bad vector sizes in vecor addition");
  Vector<T> sum = v1;
  sum += v2;
  return sum;
}

template<typename T>
Vector<T> operator-(const Vector<T>& v1, const Vector<T> & v2) {         // v=v1-v2
  //if (v1.M_size != v2.M_size ) error("bad vector sizes in vector subtraction");
  Vector<T> sum = v1;           // It would cause problem without copy constructor
  sum -= v2;
  return sum;
}
//
//
template<typename T>
T Vector<T>::twonorm() const {
  T nm = abs(M_data[0]);
  for (int i = 1; i < M_size; i++) {
    T vi = abs(M_data[i]);
    if (nm < 100) nm = sqrt(nm*nm + vi*vi);
    else {                  // to avoid overflow for fn "sqrt" when nm is large
      T tm = vi/nm;
      nm *= sqrt(1.0 + tm*tm);
    }
  }
  return nm;
}


template<typename T>
T Vector<T>::maxnorm() const {
  T nm = abs(M_data[0]);
  for (int i = 1; i < M_size; i++) {
    T vi = abs(M_data[i]);
    if (nm < vi) nm = vi;
  }
  return nm;
}
//
//
template<typename T>
Vector<T> operator*(T scalar, const Vector<T>& vec) {
  Vector<T> tm(vec.M_size);
  for (int i = 0; i < vec.M_size; i++) tm[i] = scalar*vec[i];
  return tm;
}


template<typename T>
Vector<T> operator*(const Vector<T>& vec, T scalar) {
  Vector<T> tm(vec.M_size);
  for (int i = 0; i < vec.M_size; i++) tm[i] = scalar*vec[i];
  return tm;
}


template<typename T>
T dot(const Vector<T>& v1, const Vector<T>& v2) {
  //if (v1.M_size != v2.M_size ) error("bad vector sizes in dot product");
  T tm = v1[0]*v2[0];
  for (int i = 1; i < v1.M_size; i++) tm += v1[i]*v2[i];
  return tm;
}
