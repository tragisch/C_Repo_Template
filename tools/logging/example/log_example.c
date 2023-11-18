#include "log.h"
#include <stdlib.h>

// Example log callback function
void my_log_callback(log_Event *ev) {
    fprintf(stderr, "%s:%d: %s\n", ev->file, ev->line, ev->fmt);
}

int main() {
    // Set log level
    log_set_level(LOG_TRACE);

    // Add callback for logging
    log_add_callback(my_log_callback, NULL, LOG_TRACE);

    // Example log messages
    log_trace("This is a trace message: x=%d", 1);
    log_debug("This is a debug message: x=%d", 2);
    log_info("This is an info message: x=%d", 3);
    log_warn("This is a warning message: x=%d", 4);
    log_error("This is an error message: x=%d", 5);
    log_fatal("This is a fatal error message: x=%d", 6);

    return EXIT_SUCCESS;
}
