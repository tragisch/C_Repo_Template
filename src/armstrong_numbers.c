#include "armstrong_numbers.h"

#include <stdio.h>

bool is_armstrong_number(int candidate) {
  int r, sum = 0, temp;
  int ndigits = n_digits(candidate);

  if (ndigits == 1) {
    // number with a single digits are armstrong numbers
    return true;
  } else if (ndigits == 2) {
    // number with two single digits are not armstrong numbers
    return false;
  } else {  // number has more then two digits we have to check:
    temp = candidate;

    while (candidate > 0) {
      r = candidate % 10;
      sum = sum + (int)pow(r, ndigits);
      candidate = candidate / 10;
    }

    if (temp == sum) {
      return true;
    }
  }

  return false;
}

int n_digits(int number) {
  int x = log10(number) + 1;
  return x;
}
