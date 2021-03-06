/* guppi_error.c
 *
 * Error handling routine
 */
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include "guppi_error.h"

/* For now just put it all to stderr.
 * Maybe do something clever like a stack in the future?
 */
void guppi_error(const char *name, const char *msg) {
    if(errno) {
        fprintf(stderr, "Error (%s): %s [%s]\n", name, msg, strerror(errno));
    } else {
        fprintf(stderr, "Error (%s): %s\n", name, msg);
    }
    fflush(stderr);
}

void guppi_warn(const char *name, const char *msg) {
    fprintf(stderr, "Warning (%s): %s\n", name, msg);
    fflush(stderr);
}
