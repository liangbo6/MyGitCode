#!/bin/bash

ZTRASH='/home/liangbo/Desktop/ztrash'

ARGS=`getopt -o hcfrls -l help,clean,force,recursive,list,restore -n "$0" -- "$@"`
if [ $? != 0 ]; then
	echo "Try 'rm -h' for more information."
	exit 1
fi

eval set -- "${ARGS}"
echo "all=[$@] $#"
warn=(/bin /boot /cdrom /dev /etc /home /lib /lib32 /lib64 /libx32 /lost+found /media /mnt /opt /proc /root /run /sbin /snap /srv /swapfile /sys /tmp /usr /var)
for w in ${warn[@]}
do
	for i in $@
	do
		if [ $w == $i ];then
			echo "$w is warn!"
			exit 1
		fi
	done

done
