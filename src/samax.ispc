#define NEG_INFINITY (floatbits(0xff800000))

uniform float internal_fast_cblas_samax(
    uniform const int N,
    uniform const float X[])
{
    varying int max_index = 0;
    varying float maximum = NEG_INFINITY;

    foreach(i = 0 ... N)
    {
        if (maximum < abs(X[i]))
        {
            maximum = abs(X[i]);
            max_index = i;
        }
    }

    return reduce_max(max_index);
}

uniform float internal_slow_cblas_samax(
    uniform const int N,
    uniform const float X[],
    uniform const int incX)
{
    varying int max_index = 0;
    varying float maximum = NEG_INFINITY;

    for(int i = 0; i < N; i++)
    {
        if (maximum < abs(X[i * incX]))
        {
            maximum = abs(X[i * incX]);
            max_index = i * incX;
        }
    }

    return reduce_max(max_index);
}

export uniform float cblas_samax(
    uniform const int N,
    uniform const float X[],
    uniform const int incX)
{
    if (incX == 1) {
        return internal_fast_cblas_samax(N, X);
    } else {
        return internal_slow_cblas_samax(N, X, incX);
    }
}