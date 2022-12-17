#include <iostream>
#include <cmath>
#include "bisection.hpp"

double fct(double x)
{
    return std::pow(2, -x) + std::exp(x) + 2 * std::cos(x) - 6;
}

int main()
{
    float res = bisection(1, 3, fct, 0.000001);

    std::cout << " le zéro de notre fonction est : " << res << "\n";

    return 0;
}