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

void benchmark_idamax()
{
    srand(SEED);

    double *X = malloc(sizeof(double) * XN);

    for (int i = 0; i < XN; i++)
    {
        X[i] = rand() / (double)RAND_MAX;
    }

    double total_time = 0;

    size_t max_index = 0;

    for (int i = 0; i < NTEST; i++)
    {
        struct timespec start = {0, 0};
        tic(&start);

        max_index = cblas_idamax(N, X, INC_X);

        total_time += toc(&start);
    }

    printf("cblas_idamax: Result: %ld. Average time for %d iterations: %f (ms)\n", max_index, NTEST, total_time / NTEST);
}

int main()
{
    benchmark_idamax();

    return 0;
}