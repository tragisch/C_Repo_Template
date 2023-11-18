#include <benchmark/benchmark.h>

extern "C" {
// put your C headers here
#include "armstrong_numbers.h"
}

// Example function to be benchmarked
void myFunction() {
  // ... your code here ...
  for (int i = 0; i < 10; i++) {
    is_armstrong_number(i);
  }
}

// Benchmarking function for myFunction
static void BM_myFunction(benchmark::State& state) {
  for (auto _ : state) {
    myFunction();
  }
}

// Register the function as a benchmark
BENCHMARK(BM_myFunction);

// Main function to run the benchmark
BENCHMARK_MAIN();
