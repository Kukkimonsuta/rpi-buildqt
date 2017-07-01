#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/utils/utils.sh
source $SCRIPTDIR/env.sh

if [ $# -eq 0 ]; then
   MODULES=${QT_BUILD_MODULES}
else
   MODULES=$1
fi

echo
echo "== Downloading modules (${QT_BUILD_VERSION}): ${MODULES} =="
echo

for MODULE in ${MODULES}; do
        echo
        echo == Download ${MODULE} ==
        echo
        cloneOrPull https://github.com/qt/${MODULE}.git ${RPIDEV_SRC}/${MODULE} ${QT_BUILD_VERSION}
done

echo
echo == Download modules ok ==
echo
