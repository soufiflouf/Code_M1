#pragma once

class class_root_finding
{
private:
    double e;
    int n_max;

public:
    class_root_finding();
    class_root_finding(double);
    class_root_finding(double, int);
    double operator()(double, double, double (*)(double));
    double operator()(double, double (*)(double), double (*)(double));
    double getE();
    void setE(double);
    int getN_max();
    void setN_max(int);
};