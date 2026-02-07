/**
 * @file test_example_lib.c
 * @brief Unit tests for example_lib using Unity framework
 */

#include "unity.h"
#include "example_lib.h"

void setUp(void) {
    // Set up test fixtures if needed
}

void tearDown(void) {
    // Clean up after tests if needed
}

void test_example_add_positive(void) {
    TEST_ASSERT_EQUAL_INT(30, example_add(10, 20));
}

void test_example_add_zero(void) {
    TEST_ASSERT_EQUAL_INT(5, example_add(5, 0));
}

void test_example_add_negative(void) {
    TEST_ASSERT_EQUAL_INT(0, example_add(10, -10));
}

void test_example_multiply_positive(void) {
    TEST_ASSERT_EQUAL_INT(200, example_multiply(10, 20));
}

void test_example_multiply_zero(void) {
    TEST_ASSERT_EQUAL_INT(0, example_multiply(10, 0));
}

void test_example_multiply_negative(void) {
    TEST_ASSERT_EQUAL_INT(-200, example_multiply(10, -20));
}

// The Unity test runner is generated automatically; do not define main() here.
// The generated runner will call the TEST functions declared above.
