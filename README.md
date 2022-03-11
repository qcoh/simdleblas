# simdle blas

Work in progress cblas implementation written in ispc. Mainly to learn
more about ispc and simd. Real (c)blas implementations worry about
numerical stability and other things I don't care about.

## Getting Started

### Dependencies

* ispc (tested with 1.17.0)
* g++ (tested with 9.4.0)
* libopenblas0 (for benchmarking)
* intel-mkl (for benchmarking) 

### Building

```
make
```

## License

See the LICENSE file.

## Acknowledgments

* [netlib (c)blas](https://www.netlib.org/blas/index.html) (Uses cblas.h from netlib)
* [ispc](https://ispc.github.io/)
