uniform double internal_fast_cblas_daxpy(
    uniform const int N,
    uniform const double alpha,
    uniform const double X[],
    uniform double Y[])
{  
    foreach (i = 0 ... N)
    {
        Y[i] = alpha * X[i] + Y[i];
    }
}

uniform double internal_slow_cblas_daxpy(
    uniform const int N,
    uniform const double alpha,
    uniform const double X[],
    uniform const int incX,
    uniform double Y[],
    uniform const int incY)
{
    varying int index_x = 0;
    varying int index_y = 0;

    for (varying int i = 0; i < N; i++) 
    {
        Y[index_y] = alpha * X[index_x] + Y[index_y];

        index_x += incX;
        index_y += incY;
    }
}

export uniform double cblas_daxpy(
    uniform const int N,
    uniform const double alpha,
    uniform const double X[],
    uniform const int incX,
    uniform double Y[],
    uniform const int incY)
{
    if (incX == 1 && incY == 1) {
        return internal_fast_cblas_daxpy(N, alpha, X, Y);
    } else {
        return internal_slow_cblas_daxpy(N, alpha, X, incX, Y, incY);
    }
}