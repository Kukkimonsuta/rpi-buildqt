#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/utils/utils.sh
source $SCRIPTDIR/env.sh

mkdir -p ${RPIDEV_SRC}

echo
echo == Download piomxtextures ==
echo
cloneOrPull https://github.com/carlonluca/pot.git ${RPIDEV_SRC}/piomxtextures master

echo
echo == Download piomxtextures ok ==
echo
