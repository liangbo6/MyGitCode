#!/bin/bash
#<zplibc>

ARGS=`getopt -o hl -l help,list -n "$0" -- "$@"`
if [ $? != 0 ]; then
	echo "Try 'zplibc -h' for more information."
	exit 1
fi

eval set -- "${ARGS}"

#echo "all=[$@] $#"

if [ $# == 1 ];then
	echo "The parameter is incorrect!"
	exit 1
fi
LIBC_PATH='/home/liangbo/tools/glibc-all-in-one/libs'
helpz(){
	echo "usage: zpfmt [-h]  fliename"
	echo "  -h, --help            Show help"
	echo "  -l, --list   	  List the libc "
	return 0
}
listz(){
	ls $LIBC_PATH
	return 0
}

patchz(){
	`patchelf --set-interpreter $ld $1 && patchelf --replace-needed libc.so.6 $libc $1`
	echo $ld $1
	echo $libc $1
	return 0
}
mainz(){
	until [ $# == 2 ]
	do
		if [ -x $1 ];then

			patchz $1 $ld $libc
			echo "The libc version has been successfully replaced!  $1 "
		else
			echo "    The '$1' does not exist!"
			exit 1
		fi
		shift
	done
	return 0
}
case $1 in
	-h|--help)
		helpz
		;;
	-l|--list)
		listz
		;;
	*)
		shift
		listz
		echo -n " Please enter the libc version: "
		read version
		ld=`ls $LIBC_PATH/$version/ld-*.so`
		libc=`ls $LIBC_PATH/$version/libc-*.so`
		mainz $@ $ld $libc
		;;
esac

exit 0
