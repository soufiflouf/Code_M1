#include <iostream>
#include <cmath>
#include "newton.hpp"

double fctd(double x)
{
    return 3 * std::pow(x, 2) - 10 * x + 3;
}

double fct(double x)
{
    return std::pow(x, 3) - 5 * std::pow(x, 2) + 3 * x + 7;
}

int main()
{
    double xp;

    std::cout << " choisissez un xp proche de préférence proche de notre zero"
              << "\n";
    std::cin >> xp;
    double res = newton(xp, fct, fctd, 0.000001, 10);

    std::cout << " notre racine est " << res << "\n";

    return 0;
}