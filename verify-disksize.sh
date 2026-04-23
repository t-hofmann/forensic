#!/usr/bin/env bash
set -e

DEV=${1?"DEVICE parameter missing"}

read -p "WARNING: this will overwrite data. - Continue [y,N]?" -e shall_continue
if [ "$shall_continue" != "y" ]
then
    exit 0
fi

sudo f3probe --destructive --time-ops "$DEV"
