#!/bin/bash
LIBC_PATH='/home/liangbo/tools/glibc-all-in-one/libs'

sleep 5
id=$(docker ps | grep $1 | awk '{print $1}')
libc=`ls $LIBC_PATH/$2/libc-*.so`
docker cp $libc $id:/lib/x86_64-linux-gnu/

