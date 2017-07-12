#!/bin/bash

set -e

DEPSTRING=""
for DEP in "$@"; do
        VERSION=`dpkg -s $DEP | grep -i version | awk '{print $2}' | awk -F "+" '{print $1}'`
        if [ ${#DEPSTRING} -gt 0 ]; then DEPSTRING+=", "; fi
        DEPSTRING+=" $DEP (>= $VERSION)"
done

echo Depends: $DEPSTRING
