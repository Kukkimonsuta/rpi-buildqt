#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/utils/utils.sh
source $SCRIPTDIR/env.sh

mkdir -p ${RPIDEV_SRC}

echo
echo == Download qtbase ${QT_BUILD_VERSION} ==
echo
cloneOrPull https://github.com/qt/qtbase.git ${RPIDEV_SRC}/qtbase ${QT_BUILD_VERSION}

echo
echo == Download qtbase ok ==
echo
