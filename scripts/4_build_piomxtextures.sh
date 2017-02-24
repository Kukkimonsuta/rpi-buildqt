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
    DEVICE=pi2
else
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: ${FUNCNAME[1]}: Unknown device $RPIDEV_DEVICE_VERSION." >&2
    exit 1
fi

echo
echo "== Prepare 3rd party =="
echo
cd $SOURCE_DIR/piomxtextures_tools
./prepare_3rdparty.sh ${RPIDEV_SRC}/qtbase $DEVICE

# echo
# echo "== Cleaning previous build =="
# echo
# rm -rf QT_INSTALL_DIR
# rm -rf QT_INSTALL_DIR_HOST

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