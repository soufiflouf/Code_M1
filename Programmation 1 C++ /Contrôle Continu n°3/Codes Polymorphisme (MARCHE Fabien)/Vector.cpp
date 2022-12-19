#include "Vector.hpp"
#include <cmath>

using namespace std;

// class Vector
Vector::~Vector(){
	// cout << " " << endl;
	// cout << "Destruction du vecteur: "<< M_data <<"\n";
	delete[] M_data;
}

Vector::Vector(int size, double value):M_size(size){ //constructeur 2

	M_data = new double[M_size];

	// cout << " " << endl;
	// cout << "Constructeur Vector: allocation du tableau: "<<M_data<<"\n";
  for(int kk=0; kk<M_size; ++kk) M_data[kk] = value;

}

 void Vector::affiche(){
	 cout << " " << endl;
	 cout << "les composantes du vecteur sont: " << endl;
	 cout << " " << endl;
	 for (int ii = 0; ii < M_size; ++ii){
     cout << "v["<<ii+1<<"]=" << " " << M_data[ii] << endl;
   }
 }

 // copy constructor
 Vector::Vector(Vector const &v){
 	//v.M_size==0? M_data = nullptr :
		M_data = new double[v.M_size];
	 	M_size = v.M_size;
		// cout << " " << endl;
	 	// cout << "Copy constructor: allocation du vecteur: "<<M_data<<" de taille "<<M_size<<"\n";
		// cout << " " << endl;
	 	for (int kk=0;kk<M_size;++kk) M_data[kk] = v.M_data[kk];
 }

// Vector::Vector(initializer_list<double> lst){
// 	M_data = new double[lst.size()];
// 	M_size = static_cast<int>(lst.size());
// 	cout << "Constructeur 3: allocation du vecteur: "<<M_data<<"\n";
//  	std::copy(lst.begin(), lst.end(), M_data);
// }



//
// Assigment operator

Vector& Vector::operator=(Vector const &v){
  if (this != &v){
	  delete[] M_data;
	  M_data = new double[M_size=v.M_size];
		cout << " " << endl;
	  //cout << "Affectation du vecteur: "<<v.M_data<<"\n";
	  for(int k=0;k<M_size;++k) M_data[k]=v.M_data[k];
		cout << " " << endl;
  }
  return *this;
}


// subscript operator lvalue
double& Vector::operator[](int i){
	return M_data[i];
}

// surcharge opérateur de sortie
std::ostream& operator << (std::ostream& s, const Vector& v){
  using std::endl;
  s << "Surcharge opérateur <<: taille du vecteur: " << v.M_size << endl;
  for (int i = 0; i < v.M_size; i++){
    s << i << " " << v[i] << endl;
  }
  return s;
}

int Vector::size() const{
	return M_size;
}

// surcharge operateur+ (version unaire)
Vector operator+(const Vector& vv)
{
 		return vv;
}

// surcharge operateur- (version unaire)
Vector operator-(const Vector& vv)
{
		Vector tmp(vv.size());
		for(int ii=0; ii<vv.size(); ++ii) tmp[ii] = -vv[ii];
 		return tmp;
}

// surcharge operateur+ (version binaire)
Vector operator+(const Vector& v1, const Vector& v2)
{
	if(v1.size() == v2.size())
	{
		Vector tmp(v1.size());
		for(int ii=0; ii<v1.size(); ++ii) tmp[ii] = v1[ii]+v2[ii];
		return tmp;
  }
	else
	{
	 cout << "error in operator+ : vectors dimensions do not match" << endl;
	 exit(0);
	}
}

// surcharge operateur- (version binaire)
Vector operator-(const Vector& v1, const Vector& v2)
{
	if(v1.size() == v2.size())
	{
		Vector tmp(v1.size());
		for(int ii=0; ii<v1.size(); ++ii) tmp[ii] = v1[ii]-v2[ii];
		return tmp;
  }
	else
	{
	 cout << "error in operator- : vectors dimensions do not match" << endl;
	 exit(0);
	}
}

double Vector::twonorm() const {
  double nm = pow(abs(M_data[0]),2);
  for (int i = 1; i < M_size; i++) {
    double vi = abs(M_data[i]);
    nm += vi*vi;
  }
  return sqrt(nm);
}

double Vector::maxnorm() const {
  double max = abs(M_data[0]);

  for (int i = 1; i < M_size; i++) {
    if (max < abs(M_data[i])) max = abs(M_data[i]);
  }
  return max;
}

Vector operator*(double scalar, const Vector& vec) {
  Vector tm(vec.M_size);
  for (int i = 0; i < vec.M_size; i++) tm[i] = scalar*vec[i];
  return tm;
}


Vector operator*(const Vector& vec, double scalar) {
  Vector tm(vec.M_size);
  for (int i = 0; i < vec.M_size; i++) tm[i] = scalar*vec[i];
  return tm;
}

double dot(const Vector& v1, const Vector& v2) {
  if (v1.M_size != v2.M_size ){
		cout << "bad vector sizes in dot product" << endl;
 	  exit(0);
	}
  double tm = v1[0]*v2[0];
  for (int i = 1; i < v1.M_size; i++) tm += v1[i]*v2[i];
  return tm;
}
//
Vector& Vector::operator+=(const Vector& vec) {
  if (M_size != vec.M_size){
		cout << "operator+=: bad vector sizes" << endl;
 	  exit(0);
	}
  for (int i = 0; i < M_size; i++) M_data[i] += vec.M_data[i];
  return *this;
}

Vector& Vector::operator-=(const Vector& vec) {
	if (M_size != vec.M_size){
		cout << "operator-=: bad vector sizes" << endl;
 	  exit(0);
	}
	for (int i = 0; i < M_size; i++) M_data[i] -= vec.M_data[i];
  return *this;
}
