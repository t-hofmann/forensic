#!/usr/bin/env bash
set -e

DIR=${1?"DIRECTORY parameter missing"}
DEV=${2?"DEVICE parameter missing"}

sudo nvme id-ctrl --human-readable "$DEV" | tee "$DIR/10-id-ctrl.txt"
sudo nvme smart-log --human-readable "$DEV" | tee "$DIR/20-smart-log.txt"

for _ in `seq 5`
do
    sudo hdparm -t "$DEV" | grep "Timing" | sed 's/^ //' | tee --append "$DIR/30-read-performance.txt"
done
