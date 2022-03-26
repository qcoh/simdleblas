#include "benchmark.h"

#ifdef USE_MKL
#include <mkl/mkl_blas.h>
#else
#include "cblas.h"
#endif

#include <stdio.h>
#include <stdlib.h>

#define XN 10000000
#define YN 10000000
#define N 10000000
#define INC_X 1
#define INC_Y 1

#define SEED 1234

#define NTEST 100

void benchmark_dswap()
{
    srand(SEED);

    double *X = malloc(sizeof(double) * XN);
    double *Y = malloc(sizeof(double) * XN);

    for (int i = 0; i < XN; i++)
    {
        X[i] = rand() / (double)RAND_MAX;
    }
    for (int i = 0; i < YN; i++)
    {
        Y[i] = rand() / (double)RAND_MAX;
    }

    double total_time = 0;

    for (int i = 0; i < NTEST; i++)
    {
        struct timespec start = {0, 0};
        tic(&start);

        cblas_dswap(N, X, INC_X, Y, INC_Y);

        total_time += toc(&start);
    }

    const double x1234 = X[1234];

    printf("cblas_dswap,\t\t%f,\t\t%f\n", x1234, total_time / NTEST);
}

int main()
{
    benchmark_dswap();

    return 0;
}