#include "declarations.isph"

export uniform float cblas_snrm2(
    uniform const int N,
    uniform const float X[],
    uniform const int incX)
{
    return sqrt(cblas_sdot(N, X, incX, X, incX));
}