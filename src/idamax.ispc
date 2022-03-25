#include "limits.isph"
#include "argmax.isph"

uniform size_t internal_fast_cblas_idamax(
    uniform const int N,
    uniform const double X[])
{
    varying int max_index = 0;
    varying double maximum = FLT_LOWEST;
    
    foreach (i = 0 ... N)
    {
        if (abs(X[i]) > maximum)
        {
            maximum = abs(X[i]);
            max_index = i;
        }
    }

    return argmaxf(maximum, max_index);
}

uniform size_t internal_slow_cblas_idamax(
    uniform const int N,
    uniform const double X[],
    uniform const int incX)
{
    varying int max_index = 0;
    varying double maximum = FLT_LOWEST;

    for (int i = 0; i < N; i++) 
    {
        if (abs(X[i]) > maximum)
        {
            maximum = abs(X[i]);
            max_index = i;
        }
    }

    return argmaxf(maximum, max_index);
}

export uniform size_t cblas_idamax(
    uniform const int N,
    uniform const double X[],
    uniform const int incX)
{
    if (incX == 1) {
        return internal_fast_cblas_idamax(N, X);
    } else {
        return internal_slow_cblas_idamax(N, X, incX);
    }
}