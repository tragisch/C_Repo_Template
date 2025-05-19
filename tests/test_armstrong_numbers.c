/*
 * Copyright (c) 2025 @tragisch <https://github.com/tragisch>
 * SPDX-License-Identifier: MIT
 *
 * This file is part of a project licensed under the MIT License.
 * See the LICENSE file in the root directory for details.
 */

#include "armstrong_numbers.h"

/******************************
 ** Test preconditions:
 *******************************/

#define UNITY_INCLUDE_FLOAT
#define UNITY_FLOAT_PRECISION 5

/* Support for Meta Test Rig */
#define TEST_CASE(...)

#include "unity.h"
#include "unity_internals.h"

/******************************
 ** Setup and teardown:
 *******************************/

void setUp(void) {}

void tearDown(void) {}

/******************************
 ** Test cases:
 *******************************/

void test_zero_is_an_armstrong_number(void) {
  TEST_ASSERT_TRUE(is_armstrong_number(0));
}

void test_single_digit_numbers_are_armstrong_numbers(void) {
  TEST_ASSERT_TRUE(is_armstrong_number(5));
}

void test_there_are_no_two_digit_armstrong_numbers(void) {
  TEST_ASSERT_FALSE(is_armstrong_number(10));
}

void test_three_digit_number_that_is_an_armstrong_number(void) {
  TEST_ASSERT_TRUE(is_armstrong_number(153));
}

void test_three_digit_number_that_is_not_an_armstrong_number(void) {
  TEST_ASSERT_FALSE(is_armstrong_number(100));
}

void test_four_digit_number_that_is_an_armstrong_number(void) {
  TEST_ASSERT_TRUE(is_armstrong_number(9474));
}

void test_four_digit_number_that_is_not_an_armstrong_number(void) {
  TEST_ASSERT_FALSE(is_armstrong_number(9475));
}

void test_seven_digit_number_that_is_an_armstrong_number(void) {
  TEST_ASSERT_TRUE(is_armstrong_number(9926315));
}

void test_seven_digit_number_that_is_not_an_armstrong_number(void) {
  TEST_ASSERT_FALSE(is_armstrong_number(9926314));
}

// int main(void) {
//   UnityBegin("test_armstrong_numbers.c");

//   RUN_TEST(test_zero_is_an_armstrong_number);
//   RUN_TEST(test_single_digit_numbers_are_armstrong_numbers);
//   RUN_TEST(test_there_are_no_two_digit_armstrong_numbers);
//   RUN_TEST(test_three_digit_number_that_is_an_armstrong_number);
//   RUN_TEST(test_three_digit_number_that_is_not_an_armstrong_number);
//   RUN_TEST(test_four_digit_number_that_is_an_armstrong_number);
//   RUN_TEST(test_four_digit_number_that_is_not_an_armstrong_number);
//   RUN_TEST(test_seven_digit_number_that_is_an_armstrong_number);
//   RUN_TEST(test_seven_digit_number_that_is_not_an_armstrong_number);

//   return UnityEnd();
// }
