#!/bin/bash

set -e

SCRIPTDIR=$(dirname "$0")

chmod +x $SCRIPTDIR/*.sh
chmod +x $SCRIPTDIR/utils/*.py
chmod +x $SCRIPTDIR/resources/*.sh

echo
echo == Init ok ==
echo
