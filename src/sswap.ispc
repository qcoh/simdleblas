uniform float internal_fast_cblas_sswap(
    uniform const int N,
    uniform float X[],
    uniform float Y[])
{  
    foreach (i = 0 ... N)
    {
        varying const float x_i = X[i];
        X[i] = Y[i];
        Y[i] = x_i;
    }
}

uniform float internal_slow_cblas_sswap(
    uniform const int N,
    uniform float X[],
    uniform const int incX,
    uniform float Y[],
    uniform const int incY)
{
    varying int index_x = 0;
    varying int index_y = 0;

    for (varying int i = 0; i < N; i++) 
    {
        varying const float x_i = X[index_x];
        varying const float y_i = Y[index_y];
        X[index_x] = y_i;
        Y[index_y] = x_i;

        index_x += incX;
        index_y += incY;
    }
}

export uniform float cblas_sswap(
    uniform const int N,
    uniform float X[],
    uniform const int incX,
    uniform float Y[],

    uniform const int incY)
{
    if (incX == 1 && incY == 1) {
        return internal_fast_cblas_sswap(N, X, Y);
    } else {
        return internal_slow_cblas_sswap(N, X, incX, Y, incY);
    }
}