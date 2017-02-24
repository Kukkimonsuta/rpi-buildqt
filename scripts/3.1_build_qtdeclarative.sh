#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

SOURCE_DIR=${RPIDEV_SRC}/qtdeclarative
cd $SOURCE_DIR

# echo
# echo "== Cleaning previous build =="
# echo
# rm -rf QT_INSTALL_DIR
# rm -rf QT_INSTALL_DIR_HOST

echo
echo "== Configuring qtdeclarative =="
echo
${QT_INSTALL_DIR_HOST}/bin/qmake

echo
echo "== Building qtdeclarative =="
echo
make -j${RPIDEV_JOBS}

echo
echo "== Installing qtdeclarative =="
echo
make install