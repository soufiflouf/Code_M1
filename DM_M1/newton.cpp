#include <iostream>
#include <cmath>
#include "newton.hpp"

double newton(double xp, double (*f)(double), double (*fd)(double), double e, int n_max)
{
    double x = 0;
    int i = 0;

    while (std::abs(x - xp) >= e)
    {
        std::cout << xp << "\n";
        xp = i == 0 ? xp : x;
        x = xp - (1 / (fd(xp))) * f(xp);
        i++;
        std::cout << xp << "\n";
        if (i == n_max)
        {
            std::cout << "Max number of iterations reached."
                      << "\n";
            break;
        }
    }

    return x;
}