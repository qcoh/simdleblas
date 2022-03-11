uniform float internal_fast_cblas_sasum(
    uniform const int N,
    uniform const float X[])
{
    varying double accumulator = 0.0f;
    
    foreach (i = 0 ... N)
    {
        accumulator += abs(X[i]);
    }

    return reduce_add(accumulator);
}

uniform float internal_slow_cblas_sasum(
    uniform const int N,
    uniform const float X[],
    uniform const int incX)
{
    varying double accumulator = 0.0f;

    for (int i = 0; i < N; i++) 
    {
        accumulator += abs(X[i * incX]);
    }

    return reduce_add(accumulator);
}

export uniform float cblas_sasum(
    uniform const int N,
    uniform const float X[],
    uniform const int incX)
{
    if (incX == 1) {
        return internal_fast_cblas_sasum(N, X);
    } else {
        return internal_slow_cblas_sasum(N, X, incX);
    }
}