#!/bin/bash

ZTRASH='/home/liangbo/tools/zscript/zrm/.ztrash'

ARGS=`getopt -o hcfrls -l help,clean,force,recursive,list,restore -n "$0" -- "$@"`
if [ $? != 0 ]; then
	echo "Try 'rm -h' for more information."
	exit 1
fi

eval set -- "${ARGS}"
warn=(/bin /boot /cdrom /dev /etc /home /lib /lib32 /lib64 /libx32 /lost+found /media /mnt /opt /proc /root /run /sbin /snap /srv /swapfile /sys /tmp /usr /var)
for w in ${warn[@]}
do
	for i in $@
	do
		if [ $w == $i ];then
			echo "$w is forbidden to remove!"
			exit 1
		fi
	done

done

helpz(){
	echo "safe rm [-h] [-i] [-f] [-c]...... "
	echo "  -h, --help            Show help"
	echo "  -f, --force           Delete the file directly"
	echo "  -r, --recursive       Recursively deletes files"
	echo "  -c, --clean           Clean the ztrash"
	echo "  -l, --list            List the ztrash"
	echo "  -s, --restore         Restore files in the ztrash"
	return 0
}
clean(){
	echo "ztrash:"
	echo `ls $ZTRASH`
	while true
	do
		echo -n "Are you sure to clear the trash? [y\n]: "
		read choice
		if [ ${#choice} == 0 ]
		then
			continue
		fi

		if [[ $choice = 'y' || $choice = 'Y' || $choice = 'yes' ]]
		then
			`rm -fr $ZTRASH/*` 
			`rm -fr $ZTRASH/.[^.]*` 
			echo "Emptied!"
			return 0
		fi
		if [[ $choice = 'n' || $choice = 'N' || $choice = 'no' ]]
		then
			return 0
		fi
	done
}
list(){
	echo "ztrash:"
	printf "`ls -alh $ZTRASH`\n"
	return 0
}

case "$1" in
-f|--force)
	shift;
	if [[ $1 = '-r' || $1 = 'recursive' ]]
	then
		shift 2
		if [ $# == 0 ];then
			echo "The parameter is incorrect!"
			exit 1
		fi
		`rm -fr $@`;
	elif [ $1 = '--' ]
	then
		shift
		if [ $# == 0 ];then
			echo "The parameter is incorrect!"
			exit 1
		fi
		`rm -f $@`;	
	else
		echo "Internal error!"
		echo "Try 'rm -h' for more information."
	fi
	;;
-r|--recursive)
	shift 
	if [[ $1 = '-f' || $1 = '--force' ]]
	then
		shift 2
		if [ $# == 0 ];then
			echo "The parameter is incorrect!"
			exit 1
		fi
		`rm -fr $@`;
	elif [ $1 = '--' ]
	then
		shift
		if [ $# == 0 ];then
			echo "The parameter is incorrect!"
			exit 1
		fi
		`mv $@ $ZTRASH`;
	else
		echo "Internal error!"
		echo "Try 'rm -h' for more information."
	fi
	;;
-c|--clean)
	clean
	;;
-h|--help)
	helpz
	;;
-l|--list)
	list
	;;
-s|--restore)
	shift 2
	if [ $# == 0 ];then
	echo "'-s|--restore': This option requires a parameter!"
	exit 1
	fi
	until [ $# == 0 ]
	do
		`mv $ZTRASH/$1 ./`
		shift
	done
	;;
--)
	shift
	`mv $@ $ZTRASH`
	;;
*)
	echo "Internal error!"
	echo "Try 'rm -h' for more information."
	exit 1
	;;
esac
exit 0
