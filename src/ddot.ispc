uniform double internal_fast_cblas_ddot(
    uniform const int N,
    uniform const double X[],
    uniform const double Y[])
{
    varying double accumulator = 0.0f;
    
    foreach (i = 0 ... N)
    {
        accumulator += X[i] * Y[i];
    }

    return reduce_add(accumulator);
}

uniform double internal_slow_cblas_ddot(
    uniform const int N,
    uniform const double X[],
    uniform const int incX,
    uniform const double Y[],
    uniform const int incY)
{
    varying double accumulator = 0.0f;

    for (int i = 0; i < N; i++) 
    {
        accumulator += X[i * incX] * Y[i * incY];
    }

    return reduce_add(accumulator);
}

export uniform double cblas_ddot(
    uniform const int N,
    uniform const double X[],
    uniform const int incX,
    uniform const double Y[],
    uniform const int incY)
{
    if (incX == 1 && incY == 1) {
        return internal_fast_cblas_ddot(N, X, Y);
    } else {
        return internal_slow_cblas_ddot(N, X, incX, Y, incY);
    }
}