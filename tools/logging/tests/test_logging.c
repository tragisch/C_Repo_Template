#include <stdio.h>

#include "log.h"
#include "string.h"
#include "unity.h"

// Mock function to capture log output
static char last_log[1024];
void mock_log_callback(log_Event *ev) {
  snprintf(last_log, sizeof(last_log), "%s", ev->fmt);
}

// Test for log level setting
void test_log_set_level(void) {
  log_set_level(LOG_WARN);
  log_warn("Warning level");
  TEST_ASSERT_EQUAL_STRING("Warning level", last_log);

  strcpy(last_log, "");    // Clear last log message
  log_info("Info level");  // This should not be logged due to log level setting
  TEST_ASSERT_EQUAL_STRING("Info level", last_log);
}

// Test for log callback functionality
void test_log_callback(void) {
  log_add_callback(mock_log_callback, NULL, LOG_TRACE);
  log_trace("Trace message");
  TEST_ASSERT_EQUAL_STRING("Trace message", last_log);
}

// Setup and teardown functions
void setUp(void) {
  // Initialize things before each test
  log_set_quiet(true);       // Suppressing actual log output
  log_set_level(LOG_TRACE);  // Set the lowest level to capture all messages
  log_add_callback(mock_log_callback, NULL,
                   LOG_TRACE);            // Ensure callback is set
  memset(last_log, 0, sizeof(last_log));  // Clear the last log buffer
}

void tearDown(void) {
  // Clean up after each test
}
