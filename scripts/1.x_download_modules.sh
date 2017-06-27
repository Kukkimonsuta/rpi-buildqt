#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh




if [ $# -eq 0 ]; then
   MODULES_X=${QT_INSTALL_MODULES_X}
else
   MODULES_X=$1
fi
echo "Processing modules: ${MODULES_X}"
read -p "Continue?"  -n1 -s





function cloneOrPull {
    if [ ! -d "$2" ]
    then
        git clone $1 $2 -b ${QT_INSTALL_VERSION} --depth 1 --recursive #recursive needed only for qtwebengine
    else
        git -C $2 clean -dfx
        git -C $2 reset --hard
        git -C $2 pull
    fi
} 


for m in ${MODULES_X}; do
        echo
        echo == Download ${m} ==
        echo
        cloneOrPull https://github.com/qt/${m}.git ${RPIDEV_SRC}/${m}
done

