uniform float internal_fast_cblas_scopy(
    uniform const int N,
    uniform const float X[],
    uniform float Y[])
{  
    foreach (i = 0 ... N)
    {
        Y[i] = X[i];
    }
}

uniform float internal_slow_cblas_scopy(
    uniform const int N,
    uniform const float X[],
    uniform const int incX,
    uniform float Y[],
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

export uniform float cblas_scopy(
    uniform const int N,
    uniform const float X[],
    uniform const int incX,
    uniform float Y[],
    uniform const int incY)
{
    if (incX == 1 && incY == 1) {
        return internal_fast_cblas_scopy(N, X, Y);
    } else {
        return internal_slow_cblas_scopy(N, X, incX, Y, incY);
    }
}