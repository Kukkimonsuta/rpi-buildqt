#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

function cloneOrPull {
    if [ ! -d "$2" ]
    then
        git clone $1 $2 -b $3
    else
        git -C $2 clean -dfx
        git -C $2 reset --hard
        git -C $2 pull
    fi
} 

mkdir -p ${RPIDEV_SRC}

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
echo == Download qtbase ==
echo
cloneOrPull https://github.com/qt/qtbase.git ${RPIDEV_SRC}/qtbase 5.8

echo
echo == Download qtdeclarative ==
echo
cloneOrPull https://github.com/qt/qtdeclarative.git ${RPIDEV_SRC}/qtdeclarative 5.8

echo
echo == Download qtquickcontrols ==
echo
cloneOrPull https://github.com/qt/qtquickcontrols.git ${RPIDEV_SRC}/qtquickcontrols 5.8

echo
echo == Download qtquickcontrols2 ==
echo
cloneOrPull https://github.com/qt/qtquickcontrols2.git ${RPIDEV_SRC}/qtquickcontrols2 5.8

echo
echo == Download qtmultimedia ==
echo
cloneOrPull https://github.com/qt/qtmultimedia.git ${RPIDEV_SRC}/qtmultimedia 5.8

echo
echo == Download piomxtextures ==
echo
cloneOrPull https://github.com/Kukkimonsuta/pi.git ${RPIDEV_SRC}/piomxtextures add-rpi3
