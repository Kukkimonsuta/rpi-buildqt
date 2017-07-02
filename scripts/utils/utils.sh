#!/bin/bash

set -e

function confirm {
    read -p "$1 [y/n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
}

function cloneOrPull {
    if [ ! -d "$2" ]
    then
        git clone $1 $2 -b $3 --depth 1 --recursive
    else
        git -C $2 clean -dffx
        git -C $2 submodule foreach --recursive 'git clean -dffx'
        git -C $2 reset --hard
	git -C $2 submodule foreach --recursive 'git reset --hard'
        git -C $2 pull
	git -C $2 submodule update --init --recursive
    fi
}
