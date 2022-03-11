double uniform internal_fast_cblas_dasum(
    uniform const int N,
    uniform const double X[])
{
    varying double accumulator = 0.0f;
    
    foreach (i = 0 ... N)
    {
        accumulator += abs(X[i]);
    }

    return reduce_add(accumulator);
}

double uniform internal_slow_cblas_dasum(
    uniform const int N,
    uniform const double X[],
    uniform const int incX)
{
    varying double accumulator = 0.0f;

    for (int i = 0; i < N; i++) 
    {
        accumulator += abs(X[i * incX]);
    }

    return reduce_add(accumulator);
}

export uniform double cblas_dasum(
    uniform const int N,
    uniform const double X[],
    uniform const int incX)
{
    if (incX == 1) {
        return internal_fast_cblas_dasum(N, X);
    } else {
        return internal_slow_cblas_dasum(N, X, incX);
    }
}