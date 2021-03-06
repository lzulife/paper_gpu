/*
 *  guppi_ipckey.h
 *
 *  Declare functions used to get IPC keys for GUPPI.
 */

#ifndef _GUPPI_IPCKEY_H
#define _GUPPI_IPCKEY_H

#include <sys/ipc.h>

#define GUPPI_KEY_ERROR ((key_t)-1)
/*
 * Get the base key to use for guppi databufs.
 *
 * If GUPPI_DATABUF_KEY is defined in the environment, its value is used as the
 * base databuf key.  Otherwise, the base key is obtained by calling the ftok
 * function, using the value of $GUPPI_KEYFILE, if defined, or $HOME from the
 * environment or, if $HOME is not defined, "/tmp" for the pathname and a
 * databuf specific proj_id derived from the lower 6 bits of the instance_id.
 * Use of instance_id allows a user to run multiple instances of a pipeline
 * without having to alter the environment (even from within the same process).
 *
 * By default (i.e. GUPPI_DATABUF_KEY and GUPPI_KEYFILE do not exist in the
 * environment), this will create and connect to a user specific set of shared
 * memory buffers (provided $HOME exists in the environment), but if desired
 * users can connect to any other set of memory buffers by setting
 * GUPPI_KEYFILE appropraitely.
 *
 * GUPPI_KEY_ERROR is returned on error.
 */
key_t guppi_databuf_key(int instance_id);

/*
 * Get the base key to use for the guppi status buffer.
 *
 * If GUPPI_STATUS_KEY is defined in the environment, its value is used as
 * the base databuf key.  Otherwise, the base key is obtained by calling the
 * ftok function, using the value of $GUPPI_KEYFILE, if defined, or $HOME from
 * the environment or, if $HOME is not defined, "/tmp" for the pathname and a
 * status buffer specific proj_id derived from the lower 6 bits of the
 * instance_id.  Use of instance_id allows a user to run multiple instances of
 * a pipeline without having to alter the environment (even from within the
 * same process).
 *
 * By default (i.e. GUPPI_STATUS_KEY and GUPPI_KEYFILE do not exist in the
 * environment), this will create and connect to a user specific set of shared
 * memory buffers (provided $HOME exists in the environment), but if desired
 * users can connect to any other set of memory buffers by setting
 * GUPPI_KEYFILE appropraitely.
 *
 * GUPPI_KEY_ERROR is returned on error.
 */
key_t guppi_status_key(int instance_id);

#endif // _GUPPI_IPCKEY_H
