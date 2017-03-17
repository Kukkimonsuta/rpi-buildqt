#!/bin/sh

set -e

exec "$0.real" "-isystem=/usr/include/arm-linux-gnueabihf" "-Wl,--rpath-link=${RPIDEV_SYSROOT}/lib/arm-linux-gnueabihf" "-Wl,--rpath-link=${RPIDEV_SYSROOT}/usr/lib/arm-linux-gnueabihf" "$@"
