uniform double internal_fast_cblas_dcopy(
    uniform const int N,
    uniform const double X[],
    uniform double Y[])
{  
    foreach (i = 0 ... N)
    {
        Y[i] = X[i];
    }
}

uniform double internal_slow_cblas_dcopy(
    uniform const int N,
    uniform const double X[],
    uniform const int incX,
    uniform double Y[],
    uniform const int incY)
{
    varying int index_x = 0;
    varying int index_y = 0;

    for (varying int i = 0; i < N; i++) 
    {
        Y[index_y] = X[index_x];

        index_x += incX;
        index_y += incY;
    }
}

export uniform double cblas_dcopy(
    uniform const int N,
    uniform const double X[],
    uniform const int incX,
    uniform double Y[],
    uniform const int incY)
{
    if (incX == 1 && incY == 1) {
        return internal_fast_cblas_dcopy(N, X, Y);
    } else {
        return internal_slow_cblas_dcopy(N, X, incX, Y, incY);
    }
}