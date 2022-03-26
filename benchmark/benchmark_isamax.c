#include "benchmark.h"

#ifdef USE_MKL
#include <mkl/mkl_blas.h>
#else
#include "cblas.h"
#endif

#include <stdio.h>
#include <stdlib.h>

#define XN 10000000
#define N 10000000
#define INC_X 1

#define SEED 1234

#define NTEST 100

void benchmark_isamax()
{
    srand(SEED);

    float *X = malloc(sizeof(float) * XN);

    for (int i = 0; i < XN; i++)
    {
        X[i] = rand() / (float)RAND_MAX;
    }

    double total_time = 0;

    size_t max_index = 0;

    for (int i = 0; i < NTEST; i++)
    {
        struct timespec start = {0, 0};
        tic(&start);

        max_index = cblas_isamax(N, X, INC_X);

        total_time += toc(&start);
    }

    printf("cblas_isamax,\t\t%ld,\t\t%f\n", max_index, total_time / NTEST);
}

int main()
{
    benchmark_isamax();

    return 0;
}