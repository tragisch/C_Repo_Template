#include <stdio.h>

#include "include/armstrong_numbers.h"

int main() {
  int candidates[9] = {0, 9, 1, 4, 153, 188, 370, 371, 402, 407};

  for (size_t i = 0; i < 9; i++) {
    bool armstrong = is_armstrong_number(candidates[i]);
    if (armstrong == false) {
      printf("Number %zu is an amstrong number\n", i);
    } else {
      printf("Number %zu is NOT an amstrong number\n", i);
    }
  }

  return 0;
}
