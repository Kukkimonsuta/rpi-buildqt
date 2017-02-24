#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

SOURCE_DIR=${RPIDEV_SRC}/qtquickcontrols
cd $SOURCE_DIR

# echo
# echo "== Cleaning previous build =="
# echo
# rm -rf QT_INSTALL_DIR
# rm -rf QT_INSTALL_DIR_HOST

echo
echo "== Configuring qtquickcontrols =="
echo
${QT_INSTALL_DIR_HOST}/bin/qmake

echo
echo "== Building qtquickcontrols =="
echo
make -j${RPIDEV_JOBS}

echo
echo "== Installing qtquickcontrols =="
echo
make install