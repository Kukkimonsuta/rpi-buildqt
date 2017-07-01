#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/env.sh


echo "Cleaning qtbase:"
read -p "Continue?"  -n1 -s

git -C ${RPIDEV_SRC}/qtbase clean -dfx
git -C ${RPIDEV_SRC}/qtbase reset --hard

