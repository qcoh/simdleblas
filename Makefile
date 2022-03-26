ISPCC=ispc
ISPCFLAGS= -I include/ -M --pic --target=avx2 -O3 -g
ISPCLDLIBS= -lpthread

CFLAGS += -Wall -Wextra -pedantic -I include/ -MMD -MP -O3 -g
LDLIBS +=

CXXFLAGS += -O3 -MMD -MP -fPIC -fno-exceptions
LDLIBS += -lm -ldl

SOURCES=$(wildcard src/*.ispc)
TASKSYS_OBJ=src/tasksys.o

all: build/simdle/libblas.so benchmarks

%.o: %.ispc
	$(ISPCC) $(ISPCFLAGS) $< -o $@

build/simdle/libblas.so: $(subst .ispc,.o,$(SOURCES)) $(TASKSYS_OBJ) | build
	$(CC) -shared $(LDFLAGS) -o $@ $^ -fPIC -ldl -lm

benchmarks: build/benchmark_dot build/benchmark_sum build/benchmark_isamax build/benchmark_idamax build/benchmark_sswap

build/%: LDLIBS += -lopenblas
build/%: benchmark/%.o | build build/simdle/libblas.so
	$(CC) $(LDFLAGS) $< -o $@ $(LDLIBS)

BENCHMARKS=$(wildcard build/benchmark*)
benchmark: $(BENCHMARKS) | benchmarks
	for executable in $(BENCHMARKS); do bash benchmark/benchmark_runner.sh $$executable || exit 1; done

.PHONY: all clean benchmarks build benchmark

build:
	mkdir -p build/simdle

clean:
	find . -name "*.o" -delete
	find . -name "*.d" -delete
	find . -name "*.so" -delete
	rm -rf build/

-include $(wildcard src/*.d)
-include $(wildcard benchmark/*.d)
