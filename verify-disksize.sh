#!/usr/bin/env bash
set -e

DEV=${1?"DEVICE parameter missing"}

read -p "WARNING: this will overwrite data on \"$DEV\". - Continue [y,N]?" -e SHALL_CONTINUE

if [ "$SHALL_CONTINUE" != "y" ]
then
    exit 0
fi

sudo f3probe --destructive --time-ops "$DEV"

