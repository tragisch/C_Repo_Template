
#include "include/hello.h"

#include <stdio.h>

int sum_up(int a, int b) { return a + b; }

// char* call_it_out() {}

void hello() {
  int sum = sum_up(2, 4);
  printf("Hello World, and sum: %i\n", sum);
}
