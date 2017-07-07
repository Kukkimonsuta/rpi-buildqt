#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

function remoteShell {
    sshpass -p ${RPIDEV_DEVICE_PW} ssh -p ${RPIDEV_DEVICE_PORT} ${RPIDEV_DEVICE_USER}@${RPIDEV_DEVICE_ADDRESS} $1
}

echo
echo "== Create dest directory =="
echo
remoteShell "sudo mkdir -p ${QT_DEVICE_DIR}"

echo
echo "== Copy qt =="
echo
rsync -avztr --delete --rsync-path="sudo rsync" --rsh="/usr/bin/sshpass -p ${RPIDEV_DEVICE_PW} ssh -p ${RPIDEV_DEVICE_PORT} -o StrictHostKeyChecking=no -l ${RPIDEV_DEVICE_USER}" ${QT_INSTALL_DIR}/* ${RPIDEV_DEVICE_ADDRESS}:${QT_DEVICE_DIR}

echo
echo "== Copy poc player =="
echo
sshpass -p ${RPIDEV_DEVICE_PW} scp -P ${RPIDEV_DEVICE_PORT} ${RPIDEV_SRC}/piomxtextures/piomxtextures_pocplayer/piomxtextures_pocplayer ${RPIDEV_DEVICE_USER}@${RPIDEV_DEVICE_ADDRESS}:~/


echo
echo "== ldconfig =="
echo
remoteShell "echo ${QT_DEVICE_DIR}/lib | sudo tee /etc/ld.so.conf.d/qt5.conf"
remoteShell "sudo ldconfig"

echo
echo "== Copy to device ok =="
echo

