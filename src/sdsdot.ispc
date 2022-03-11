uniform float internal_fast_cblas_sdsdot(
    uniform const int N,
    uniform const float alpha,
    uniform const float X[],
    uniform const float Y[])
{
    varying float accumulator = alpha;
    
    foreach (i = 0 ... N)
    {
        accumulator += X[i] * Y[i];
    }

    return reduce_add(accumulator);
}

uniform float internal_slow_cblas_sdsdot(
    uniform const int N,
    uniform const float alpha,
    uniform const float X[],
    uniform const int incX,
    uniform const float Y[],
    uniform const int incY)
{
    varying float accumulator = alpha;

    for (int i = 0; i < N; i++) 
    {
        accumulator += X[i * incX] * Y[i * incY];
    }

    return reduce_add(accumulator);
}

export uniform float cblas_sdsdot(
    uniform const int N,
    uniform const float alpha,
    uniform const float X[],
    uniform const int incX,
    uniform const float Y[],
    uniform const int incY)
{
    if (incX == 1 && incY == 1) {
        return internal_fast_cblas_sdsdot(N, alpha, X, Y);
    } else {
        return internal_slow_cblas_sdsdot(N, alpha, X, incX, Y, incY);
    }
}