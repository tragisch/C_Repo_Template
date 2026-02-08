/**
 * @file main.c
 * @brief Example application demonstrating library usage
 */

#include <stdio.h>
#include "example_lib.h"

int main(void) {
    printf("Welcome to Example Application\n");
    printf("==============================\n\n");

    int a = 10;
    int b = 20;

    printf("Testing example_lib functions:\n");
    printf("  a = %d, b = %d\n", a, b);
    printf("  example_add(%d, %d) = %d\n", a, b, example_add(a, b));
    printf("  example_multiply(%d, %d) = %d\n", a, b, example_multiply(a, b));
    return 0;
}
