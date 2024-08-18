#!/bin/bash

ARGS=`getopt -o h -l help -n "$0" -- "$@"`
if [ $? != 0 ]; then
	echo "Try 'expt -h' for more information."
	exit 1
fi

eval set -- "${ARGS}"

helpz(){
	echo " zpexpt [-h] [filename]  ...... "
	echo "  -h, --help            Show help"
	return 0
}

checkFile(){
	if [ -f $1 ];then
		while true
		do

			echo -n "File $1 already exists,Do you want to overwrite it?[y/n]: "
			read choice
			if [ "${choice}" = 'yes' ] || [ "${choice}" = 'y' ] || [ "${choice}" = 'Y' ] || [ "${choice}" = "YES" ];then
				break
			elif [ "${choice}" = 'no' ] || [ "${choice}" = 'n' ] || [ "${choice}" = 'N' ] || [ "${choice}" = "NO" ];then
				exit -1
			else 
				continue
			fi 
		done
	fi
}

case $1 in
	-h|--help)
		helpz
		exit 0
		;;
	--)
		shift
		if [ $# == 0 ];then
			checkFile "$(pwd)/exp.py"
			`cp /home/liangbo/tools/zscript/zpexpt/expt.py $(pwd)/exp.py`
		else
			until [ $# == 0 ]
			do
				checkFile "$(pwd)/$1"
				`cp /home/liangbo/tools/zscript/zpexpt/expt.py $(pwd)/$1`
			shift
			done
		fi
		exit 0
		;;
	*)
		echo "The parameter is incorrect!"
		echo "Try 'expt -h' for more information."
		exit 1
		;;
esac

