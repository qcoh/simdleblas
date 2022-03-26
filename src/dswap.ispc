uniform double internal_fast_cblas_dswap(
    uniform const int N,
    uniform double X[],
    uniform double Y[])
{  
    foreach (i = 0 ... N)
    {
        varying const double x_i = X[i];
        X[i] = Y[i];
        Y[i] = x_i;
    }
}

uniform double internal_slow_cblas_dswap(
    uniform const int N,
    uniform double X[],
    uniform const int incX,
    uniform double Y[],
    uniform const int incY)
{
    varying int index_x = 0;
    varying int index_y = 0;

    for (varying int i = 0; i < N; i++) 
    {
        varying const double x_i = X[index_x];
        varying const double y_i = Y[index_y];
        X[index_x] = y_i;
        Y[index_y] = x_i;

        index_x += incX;
        index_y += incY;
    }
}

export uniform double cblas_dswap(
    uniform const int N,
    uniform double X[],
    uniform const int incX,
    uniform double Y[],

    uniform const int incY)
{
    if (incX == 1 && incY == 1) {
        return internal_fast_cblas_dswap(N, X, Y);
    } else {
        return internal_slow_cblas_dswap(N, X, incX, Y, incY);
    }
}