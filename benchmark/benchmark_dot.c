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

void benchmark_sdot()
{
    srand(SEED);

    float *X = malloc(sizeof(float) * XN);
    float *Y = malloc(sizeof(float) * YN);

    for (int i = 0; i < XN; i++)
    {
        X[i] = rand() / (float)RAND_MAX;
    }

    for (int i = 0; i < YN; i++)
    {
        Y[i] = rand() / (float)RAND_MAX;
    }

    double total_time = 0;

    float dot_product = 0;

    for (int i = 0; i < NTEST; i++)
    {
        struct timespec start = {0, 0};
        tic(&start);

        dot_product = cblas_sdot(N, X, INC_X, Y, INC_Y);

        total_time += toc(&start);
    }

    printf("cblas_sdot: Result: %f. Average time for %d iterations: %f (ms)\n", dot_product, NTEST, total_time / NTEST);
}

void benchmark_ddot()
{
    srand(SEED);

    double *X = malloc(sizeof(double) * XN);
    double *Y = malloc(sizeof(double) * YN);

    for (int i = 0; i < XN; i++)
    {
        X[i] = rand() / (double)RAND_MAX;
    }

    for (int i = 0; i < YN; i++)
    {
        Y[i] = rand() / (double)RAND_MAX;
    }

    double total_time = 0;

    double dot_product = 0;

    for (int i = 0; i < NTEST; i++)
    {
        struct timespec start = {0, 0};
        tic(&start);

        dot_product = cblas_ddot(N, X, INC_X, Y, INC_Y);

        total_time += toc(&start);
    }

    printf("cblas_ddot: Result: %f. Average time for %d iterations: %f (ms)\n", dot_product, NTEST, total_time / NTEST);
}

int main()
{
    benchmark_sdot();
    benchmark_ddot();

    return 0;
}