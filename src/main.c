/*
 * Copyright (c) 2025 @tragisch <https://github.com/tragisch>
 * SPDX-License-Identifier: MIT
 *
 * This file is part of a project licensed under the MIT License.
 * See the LICENSE file in the root directory for details.
 */

#include <stdio.h>

#include "armstrong_numbers.h"

int main() {
  int candidates[10] = {0, 9, 1, 4, 153, 188, 370, 371, 402, 407};

  for (size_t i = 0; i < 9; i++) {
    bool armstrong = is_armstrong_number(candidates[i]);
    if (armstrong == false) {
      printf("Number %d is an amstrong number\n", candidates[i]);
    } else {
      printf("Number %d is NOT an amstrong number\n", candidates[i]);
    }
  }

  return 0;
}
