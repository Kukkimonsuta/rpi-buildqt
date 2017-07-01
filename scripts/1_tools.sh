#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/utils/utils.sh
source $SCRIPTDIR/env.sh

mkdir -p $(dirname $(realpath ${RPIDEV_TOOLS}))

echo
echo == Download tools ==
echo
cloneOrPull https://github.com/raspberrypi/tools.git ${RPIDEV_TOOLS} master

echo
echo == Fix tools ==
echo
mv ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc.real
mv ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-g++.real

cp ${SCRIPTDIR}/resources/gcc.sh ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc
cp ${SCRIPTDIR}/resources/gcc.sh ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-g++

chmod +x ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc
chmod +x ${RPIDEV_TOOLS}/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-g++

echo
echo == Tools ok ==
echo
