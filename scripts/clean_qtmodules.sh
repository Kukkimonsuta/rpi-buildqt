#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh

if [ $# -eq 0 ]; then
   MODULES_X=${QT_INSTALL_MODULES_X}
else
   MODULES_X=$1
fi
echo "Cleaning modules: ${MODULES_X}"
read -p "Continue?"  -n1 -s

function clean {
        git -C $2 clean -dfx
        git -C $2 reset --hard
} 

for m in ${MODULES_X}; do
        echo
        echo == Download ${m} ==
        echo
        clean https://github.com/qt/${m}.git ${RPIDEV_SRC}/${m}
done

