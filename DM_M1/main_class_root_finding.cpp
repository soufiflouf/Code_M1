#include <iostream>
#include <cmath>
#include "class_root_finding.hpp"

double fctd(double x)
{
    return 3 * std::pow(x, 2) - 10 * x + 3;
}

double fct(double x)
{
    return std::pow(x, 3) - 5 * std::pow(x, 2) + 3 * x + 7;
}

double fct3(double x)
{
    return std::pow(2, -x) + std::exp(x) + 2 * std::cos(x) - 6;
}

int main()
{
    class_root_finding test = class_root_finding();

    double res1 = test(4.0, fct, fctd);
    double res2 = test(1.0, 3.0, fct3);
    std::cout << res1 << "\n";
    std::cout << res2 << "\n";

    return 0;
}