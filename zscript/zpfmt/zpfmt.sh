#!/bin/bash

#<zpfmt.sh>


ARGS=`getopt -o hm:n:l: -l help,machine:,length:,look: -n "$0" -- "$@"`
if [ $? != 0 ]; then
	echo "Try 'zpfmt -h' for more information."
	exit 1
fi

eval set -- "${ARGS}"

#echo "all=[$@] $#"

echo_help(){
	echo "The parameter is incorrect!"
	echo "Try 'zpfmt -h' for more information."
	return 0
}
	
helpz(){
	echo "usage: zpfmt [-h]  [-m machine word]  [-n length]  [-l lookup_offset]"
	echo "  -h, --help            Show help"
	echo "  -m, --machine         Whether this machine is 32-bit or 64-bit"
	echo "  -n, --length          Size of the unique subsequences (defaults to 4 or 8)."
	echo "  -l, --lookup_offset   Find it, and print out the offset "
	return 0
}
print32(){

	expr $1 "+" 10 &> /dev/null
		if [ $? -ne 0 ];then
			echo "$1 is not a number!"
			exit 2
		fi
	local str="aaaa"
	local counts=$(($1-1))
	until [ $counts == 0 ];do
		str=$str%p-
		counts=$((counts-1))
	done
	echo $str%p
	return 0
}
print64(){
	expr $1 "+" 10 &> /dev/null
		if [ $? -ne 0 ];then
			echo "$1 is not a number!"
			exit 2
		fi
	local str="aaaaaaaa"
	local counts=$(($1-1))
	until [ $counts == 0 ];do
		str=$str%p-
		counts=$((counts-1))
	done
	echo $str%p
	return 0
}
lookup(){
#echo "echo $1  offset "
	local fmtstr=$1
	fmtstr=${fmtstr%%0x61616161*}
	echo "${fmtstr}0x61616161"
	local offset=`echo $fmtstr | grep -o '-' | wc -l`
	echo -e "\033[32mThe offset is: \033[0m$((offset+1))"
	return 0

}

case $1 in
	-h|--help)
		helpz
		;;
	-m|--machine)
		shift 
		if [ $1 == 32 ];then
			shift
			if [ $1 == '-n' ] || [ $1 == '--length' ];then
				print32 $2
			elif [ $1 == '--' ];then
				print32 20
			else
				echo_help
				exit 1
			fi
		elif [ $1 == 64 ];then
			shift
			if [ $1 == '-n' ] || [ $1 == '--length' ];then
				print64 $2
			elif [ $1 == '--' ];then
				print64 20
			else
				echo_help
				exit 1
			fi
		else
			echo_help
			exit 1
		fi
		;;
	-n|length)
		shift
		print64 $1
		;;
	-l|--look)
		shift 
		lookup $1
		;;
	--)
		print64 20
		;;

	*)
		echo_help
		exit 1
		;;
		
esac
exit 0
