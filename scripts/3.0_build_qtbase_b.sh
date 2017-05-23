#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

SOURCE_DIR=${RPIDEV_SRC}/qtbase
cd $SOURCE_DIR


echo
echo "== Building qtbase =="
echo
make -j${RPIDEV_JOBS}

echo
echo "== Installing qtbase =="
echo
make install
