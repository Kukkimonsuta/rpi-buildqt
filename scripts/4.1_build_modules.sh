#!/bin/bash
set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh
source $SCRIPTDIR/utils/utils.sh

if [ $# -eq 0 ]; then
   MODULES=${QT_BUILD_MODULES}
else
   MODULES=$1
fi

echo
echo "== Building modules (${QT_BUILD_VERSION}): ${MODULES}"
echo

for MODULE in ${MODULES}; do
	QMAKE_ARGS=""
	if [ "$MODULE" == "qtwebengine" ]; then
            QMAKE_ARGS="WEBENGINE_CONFIG+=use_proprietary_codecs QMAKE_LIBDIR_OPENGL_ES2=\"/usr/lib/arm-linux-gnueabihf\" QMAKE_LIBDIR_EGL=\"/usr/lib/arm-linux-gnueabihf\""
	fi

	cd ${RPIDEV_SRC}/$MODULE

	echo
	echo "== Configuring ${MODULE} =="
	echo
	${QT_INSTALL_DIR_HOST}/bin/qmake ${QMAKE_ARGS}

	echo
	echo "== Building ${MODULE} =="
	echo
	make -j${RPIDEV_JOBS}

	echo
	echo "== Installing ${MODULE} =="
	echo
	make install
done

echo
echo "== Build modules ok =="
echo
