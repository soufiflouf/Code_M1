#include <iostream>
#include <cmath>
#include "bisection.hpp"

double bisection(double a, double b, double (*f)(double), double e)
{
    double c, fc = 0;
    double fb = (*f)(b);
    double fa = (*f)(a);

    if (fa * fb >= 0)
    {
        std::cout << "bisect error: f(a)*f(b)>=0.0"
                  << "\n";

        return 0;
    }

    while (std::abs(b - a) >= e)
    {
        c = ((b + a) / (2));
        fc = (*f)(c);

        if (fa * fc <= 0)
        {
            b = c;
            fb = fc;
        }
        else
        {
            a = c;
            fa = fc;
        }
    }

    return c;
}