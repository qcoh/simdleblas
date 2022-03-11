#include "declarations.isph"

export uniform double cblas_dnrm2(
    uniform const int N,
    uniform const double X[],
    uniform const int incX)
{
    return sqrt(cblas_ddot(N, X, incX, X, incX));
}