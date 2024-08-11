#!/bin/bash
#<zdocker>

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
helpz(){
	echo "usage: zdocker [-h]  fliename"
	echo "  -h, --help            Show help"
	echo "  -l, --list   	  List the images "
	return 0
}
listz(){
	docker image ls
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
		if [ $# == 2 ];then
			/home/liangbo/tools/zscript/zdocker/docker_cp.sh $@ &>/dev/null &
		fi
		docker run -it --rm -v ./:/home/ctf/hacker/ -p 1234:80 --cap-add=SYS_PTRACE $1 /bin/zsh	
		;;
esac

exit 0

