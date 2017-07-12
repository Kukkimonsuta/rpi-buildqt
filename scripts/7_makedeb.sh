#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env-package.sh

echo
echo "== Cleanup of ${RPIQTPKG_BUILD_DIR} =="
echo
rm -Rf ${RPIQTPKG_BUILD_DIR}
mkdir -p ${RPIQTPKG_ROOT}

echo
echo "== Copying files from ${QT_INSTALL_DIR} to ${RPIQTPKG_ROOT} =="
echo
cp -r ${QT_INSTALL_DIR}/* ${RPIQTPKG_ROOT}

echo
echo "== Getting dependencies version =="
echo
sshpass -p ${RPIDEV_DEVICE_PW} scp -P ${RPIDEV_DEVICE_PORT} $SCRIPTDIR/rpiqt-deps.sh ${RPIDEV_DEVICE_USER}@${RPIDEV_DEVICE_ADDRESS}:/tmp
DEPENDENCIES=`sshpass -p ${RPIDEV_DEVICE_PW} ssh -p ${RPIDEV_DEVICE_PORT} ${RPIDEV_DEVICE_USER}@${RPIDEV_DEVICE_ADDRESS} "chmod +x /tmp/rpiqt-deps.sh && /tmp/rpiqt-deps.sh ${RPIQTPKG_DEPENDENCIES}"`
echo $DEPENDENCIES

echo
echo "== Creating control file =="
echo
mkdir -p ${RPIQTPKG_ROOT}/DEBIAN
cat << EOF > ${RPIQTPKG_ROOT}/DEBIAN/control
Package: ${RPIQTPKG_TITLE}
Version: ${RPIQTPKG_VERSION}
Section: base
Priority: optional
Architecture: armhf
$DEPENDENCIES
Maintainer: ${RPIQTPKG_MAINTAINER}
Description: Custom build of Qt ${QT_BUILD_VERSION} for raspberry ${RPIDEV_DEVICE_VERSION}
 When you need some sunshine, just run this
 small program!
EOF
cat ${RPIQTPKG_ROOT}/DEBIAN/control

echo
echo "== Building the package =="
echo
dpkg-deb --build ${RPIQTPKG_ROOT}

echo
echo "== Done. =="
echo
