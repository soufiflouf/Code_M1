#include <iostream>
#include "class_root_finding.hpp"
#include "newton.hpp"
#include "bisection.hpp"

class_root_finding::class_root_finding() : e(0.000001), n_max(10)
{
    std::cout << "Initialising with default e:(0.000001) and default n_max:(10)."
              << "\n";
}

class_root_finding::class_root_finding(double e) : n_max(10)
{
    std::cout << "Initialising with default n_max:(10)."
              << "\n";
    this->e = e;
}

class_root_finding::class_root_finding(double e, int n_max)
{
    this->e = e;
    this->n_max = n_max;
}

double class_root_finding::operator()(double a, double b, double (*f)(double))
{
    return bisection(a, b, f, e);
}

double class_root_finding::operator()(double xp, double (*f)(double), double (*fd)(double))
{
    return newton(xp, f, fd, e, n_max);
}

double class_root_finding::getE()
{
    return e;
}

void class_root_finding::setE(double e)
{
    this->e = e;
}

int class_root_finding::getN_max()
{
    return n_max;
}

void class_root_finding::setN_max(int n_max)
{
    this->n_max = n_max;
}