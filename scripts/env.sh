#!/bin/bash

RPIDEV_ROOT=~/raspi
export RPIDEV_TOOLS=${RPIDEV_ROOT}/tools
export RPIDEV_SRC=${RPIDEV_ROOT}/src
export RPIDEV_BUILD=${RPIDEV_ROOT}/build
export RPIDEV_SYSROOT=${RPIDEV_ROOT}/sysroot

export RPIDEV_JOBS=$(grep -c "^processor" /proc/cpuinfo)

# device info
export RPIDEV_DEVICE_VERSION=pi3            # pi1 pi2 pi3 (only tested pi3)
export RPIDEV_DEVICE_ADDRESS=10.0.50.124    # ip if device
export RPIDEV_DEVICE_USER=pi                # username
export RPIDEV_DEVICE_PW=raspberry           # password

# qt paths
export QT_INSTALL_DIR=${RPIDEV_BUILD}/qt5.8
export QT_INSTALL_DIR_HOST=${RPIDEV_BUILD}/qt5.8-host
export QT_DEVICE_DIR=/usr/local/qt5.8

# configure piomxtextures
export RPI_SYSROOT=${RPIDEV_SYSROOT}
export COMPILER_PATH=${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin

# configure pkg config
export PKG_CONFIG_DIR=
export PKG_CONFIG_LIBDIR=${RPIDEV_SYSROOT}/usr/lib/pkgconfig:${RPIDEV_SYSROOT}/usr/share/pkgconfig:${RPIDEV_SYSROOT}/usr/lib/arm-linux-gnueabihf/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=${RPIDEV_SYSROOT}
