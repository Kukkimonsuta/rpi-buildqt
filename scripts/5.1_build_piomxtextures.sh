#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

SOURCE_DIR=${RPIDEV_SRC}/piomxtextures

DEVICE=
if [ "$RPIDEV_DEVICE_VERSION" == "pi1" ]; then
    DEVICE=pi1
elif [ "$RPIDEV_DEVICE_VERSION" == "pi2" ]; then
    DEVICE=pi2
elif [ "$RPIDEV_DEVICE_VERSION" == "pi3" ]; then
    DEVICE=pi3
else
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: ${FUNCNAME[1]}: Unknown device $RPIDEV_DEVICE_VERSION." >&2
    exit 1
fi

echo
echo "== Clean previous build =="
echo
cd $SOURCE_DIR
rm -rf 3rdparty
git clean -xdf

echo
echo "== Prepare 3rd party =="
echo
cd $SOURCE_DIR/piomxtextures_tools
./prepare_3rdparty.sh ${RPIDEV_SRC}/qtbase $DEVICE

echo
echo "== TEMP: use older LightLogger =="
echo
cd $SOURCE_DIR/3rdparty/LightLogger
git fetch --unshallow
git checkout d39a9f2e88551708a39cf60308b66f9f7f7579a3

echo
echo "== Configuring piomxtextures =="
echo
cd $SOURCE_DIR
${QT_INSTALL_DIR_HOST}/bin/qmake

echo
echo "== Building piomxtextures =="
echo
make -j${RPIDEV_JOBS}

echo
echo "== Installing piomxtextures =="
echo
make install

cp ${SOURCE_DIR}/piomxtextures_qt_driver/mediaplayer/libopenmaxilmediaplayer.so* ${QT_INSTALL_DIR}/plugins/mediaservice/
