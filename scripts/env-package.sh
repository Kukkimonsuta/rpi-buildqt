#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

# from https://ubuntuforums.org/showthread.php?t=910717

# package name, all lowercase, in the form <project>_<major version>.<minor version>-<package revision>
export RPIQTPKG_TITLE=qt-${RPIDEV_DEVICE_VERSION}
export RPIQTPKG_VERSION=5.9-1
export RPIQTPKG_NAME=${RPIQTPKG_TITLE}_${RPIQTPKG_VERSION}

#required raspberry pi dependecies
#qtbase
export RPIQTPKG_DEPENDENCIES="libboost1.55-all-dev libudev-dev libinput-dev libts-dev libmtdev-dev libjpeg-dev libfontconfig1-dev libssl-dev libdbus-1-dev libglib2.0-dev libxkbcommon-dev"
#qtmultimedia
export RPIQTPKG_DEPENDENCIES+=" libasound2-dev libpulse-dev gstreamer1.0-omx libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev"
#qtwebengine
export RPIQTPKG_DEPENDENCIES+=" libvpx-dev libsrtp0-dev libsnappy-dev libnss3-dev"

# package data
export RPIQTPKG_MAINTAINER='Your Name <you@email.com>'

export RPIQTPKG_BUILD_DIR=${RPIDEV_ROOT}/package
export RPIQTPKG_ROOT=${RPIQTPKG_BUILD_DIR}/${RPIQTPKG_NAME}
