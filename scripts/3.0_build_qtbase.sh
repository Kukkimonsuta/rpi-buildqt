#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

SOURCE_DIR=${RPIDEV_SRC}/qtbase
cd $SOURCE_DIR

echo
echo "== Cleaning previous build =="
echo
rm -rf ${QT_INSTALL_DIR}
rm -rf ${QT_INSTALL_DIR_HOST}

echo
echo "== Configuring qtbase =="
echo

DEVICE=
if [ "$RPIDEV_DEVICE_VERSION" == "pi1" ]; then
    DEVICE=linux-rasp-pi-g++
elif [ "$RPIDEV_DEVICE_VERSION" == "pi2" ]; then
    DEVICE=linux-rasp-pi2-g++
elif [ "$RPIDEV_DEVICE_VERSION" == "pi3" ]; then
    DEVICE=linux-rasp-pi3-g++ # was linux-rpi3-g++ for 5.8?
else
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: ${FUNCNAME[1]}: Unknown device $RPIDEV_DEVICE_VERSION." >&2
    exit 1
fi

./configure -release -opengl es2 -no-opengles3 ${QT_BASE_CONFIGURE_EXTRA} -device  \
    -device-option CROSS_COMPILE=${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- \
    -sysroot ${RPIDEV_SYSROOT} -opensource -confirm-license -make libs \
    -prefix ${QT_DEVICE_DIR} -extprefix ${QT_INSTALL_DIR} -hostprefix ${QT_INSTALL_DIR_HOST} -v

read -p "Continue building? [y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo
echo "== Building qtbase =="
echo
make -j${RPIDEV_JOBS}

echo
echo "== Installing qtbase =="
echo
make install
