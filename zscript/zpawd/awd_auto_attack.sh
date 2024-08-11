#!/bin/bash

ARGS=`getopt -o h -l help -n "$0" -- "$@"`
if [ $? != 0 ]; then
	echo "Try 'zpawd -h' for more information."
	exit 1
fi

eval set -- "${ARGS}"

helpz(){
	echo " zpawd [-h] [filename]  ...... "
	echo "  -h, --help            Show help"
	return 0
}




case $1 in
	-h|--help)
		helpz
		exit 0
		;;
	--)
		shift
		if [ $# == 0 ];then
			`cp /home/liangbo/tools/zscript/zpawd/awd3.py $(pwd)/awd.py`
		else
			until [ $# == 0 ]
			do
				`cp /home/liangbo/tools/zscript/zpawd/awd3.py $(pwd)/$1`
			shift
			done
		fi
		exit 0
		;;
	*)
		echo "The parameter is incorrect!"
		echo "Try 'zpawd -h' for more information."
		exit 1
		;;
esac


