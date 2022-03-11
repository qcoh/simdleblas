#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void tic(struct timespec *start)
{
    clock_gettime(CLOCK_REALTIME, start);
}

double toc(struct timespec *start)
{
    struct timespec stop = {0, 0};
    clock_gettime(CLOCK_REALTIME, &stop);

    return (double)(stop.tv_sec - start->tv_sec) * 1.e3 + (double)((stop.tv_nsec - start->tv_nsec)) * 1.e-6;
}
