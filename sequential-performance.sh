#!/usr/bin/env bash
set -e

FILE=${1?"FILE or DEVICE parameter missing"}

fio --name READ_TEST \
    --rw=read --filename="$FILE" \
    --eta-newline=5s --size=500m --io_size=10g --blocksize=1024k \
    --ioengine=libaio --fsync=10000 --iodepth=32 --direct=1 \
    --numjobs=1 --runtime=60 --group_reporting

read -p "WARNING: this will overwrite data. - Continue [y,N]?" -e shall_continue
if [ "$shall_continue" != "y" ]
then
    exit 0
fi

fio --name WRITE_TEST \
    --rw=write --filename="$FILE" \
    --eta-newline=5s --size=500m --io_size=10g --blocksize=1024k \
    --ioengine=libaio --fsync=10000 --iodepth=32 --direct=1 \
    --numjobs=1 --runtime=60 --group_reporting