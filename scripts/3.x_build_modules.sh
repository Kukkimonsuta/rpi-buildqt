#!/bin/bash
set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

SOURCE_DIR=${RPIDEV_SRC}
cd $SOURCE_DIR



if [ $# -eq 0 ]; then
   MODULES_X=${QT_INSTALL_MODULES_X}
else
   MODULES_X=$1
fi
echo "Processing modules: ${MODULES_X}"
read -p "Continue?"  -n1 -s



for m in ${MODULES_X}; do
	buildArg=""
	if [ $m = "qtwebengine" ]; then
		buildArg="WEBENGINE_CONFIG+=use_proprietary_codecs"
	fi

	cd $m
	echo
	echo "== Configuring ${m} =="
	echo
	${QT_INSTALL_DIR_HOST}/bin/qmake -r ${buildArg}
	
	echo
	echo "== Building ${m} =="
	echo
	make -j${RPIDEV_JOBS}
	
	echo
	echo "== Installing ${m} =="
	echo
	make install


	cd ../
	echo
	read -p " == Finished ${m} ==  Continue?"  -n1 -s
done
echo
echo " All modules done."
