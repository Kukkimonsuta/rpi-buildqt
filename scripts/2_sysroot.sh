#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

mkdir -p ${RPIDEV_SYSROOT}/usr
mkdir -p ${RPIDEV_SYSROOT}/opt

echo
echo "== Copy /lib =="
echo
rsync -avztr --delete --rsync-path="sudo rsync" --rsh="/usr/bin/sshpass -p ${RPIDEV_DEVICE_PW} ssh -p ${RPIDEV_DEVICE_PORT} -o StrictHostKeyChecking=no -l ${RPIDEV_DEVICE_USER}" ${RPIDEV_DEVICE_ADDRESS}:/lib ${RPIDEV_SYSROOT}

echo
echo "== Copy /usr/include =="
echo
rsync -avztr --delete --rsync-path="sudo rsync" --rsh="/usr/bin/sshpass -p ${RPIDEV_DEVICE_PW} ssh -p ${RPIDEV_DEVICE_PORT} -o StrictHostKeyChecking=no -l ${RPIDEV_DEVICE_USER}" ${RPIDEV_DEVICE_ADDRESS}:/usr/include ${RPIDEV_SYSROOT}/usr

echo
echo "== Copy /usr/lib =="
echo
rsync -avztr --delete --rsync-path="sudo rsync" --rsh="/usr/bin/sshpass -p ${RPIDEV_DEVICE_PW} ssh -p ${RPIDEV_DEVICE_PORT} -o StrictHostKeyChecking=no -l ${RPIDEV_DEVICE_USER}" ${RPIDEV_DEVICE_ADDRESS}:/usr/lib ${RPIDEV_SYSROOT}/usr

echo
echo "== Copy /opt/vc =="
echo
rsync -avztr --delete --rsync-path="sudo rsync" --rsh="/usr/bin/sshpass -p ${RPIDEV_DEVICE_PW} ssh -p ${RPIDEV_DEVICE_PORT} -o StrictHostKeyChecking=no -l ${RPIDEV_DEVICE_USER}" ${RPIDEV_DEVICE_ADDRESS}:/opt/vc ${RPIDEV_SYSROOT}/opt

echo
echo "== Fix links =="
echo
${SCRIPTDIR}/utils/sysroot-relativelinks.py ${RPIDEV_SYSROOT}

echo
echo "== Link lib paths =="
echo
ln -s ${RPIDEV_SYSROOT}/lib/arm-linux-gnueabihf ${RPIDEV_SYSROOT}/lib/arm-linux-gnueabihf/4.9.3
ln -s ${RPIDEV_SYSROOT}/usr/lib/arm-linux-gnueabihf ${RPIDEV_SYSROOT}/usr/lib/arm-linux-gnueabihf/4.9.3

echo
echo "== Sysroot ok =="
echo
