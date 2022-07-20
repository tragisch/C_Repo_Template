#include <TargetConditionals.h>
#include <gtest/gtest.h>

extern "C" {
#include "src/lib/include/hello.h"
}

// Demonstrate some basic assertions.
TEST(sum_up, sumcorrect) {
  int sum = sum_up(4, 8);
  // Expect equality.
  EXPECT_EQ(sum, 12);
}