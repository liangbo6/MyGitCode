#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
"""
from pwncli import *
#from LibcSearcher import *
#import base64
#import hashlib
is_debug=1
file_name=''

e=ELF(file_name)
#context.log_level='debug'
#context.arch='amd64'
context.timeout=5
context.terminal=['tmux','splitw','-h']
ls=lambda value,s='' : log.success("\033[34m"+s+"\033[0m"+"\033[35m=======>\033[0m"+"\033[33m"+value+"\033[0m")
li=lambda value : log.info("\033[38m"+value+"\033[0m")
lw=lambda value : log.warning("\033[31m"+value+"\033[0m")
l64=lambda : u64(ru(b"\x7f")[-6:].ljust(8,b"\x00"))
l32=lambda : u32(ru(b"\xf7")[-4:].ljust(4,b"\x00"))
if is_debug:
	io=process(file_name)
	libc=e.libc
else:
	io=remote('pwn.challenge.ctf.show',28172)
#libc=ELF('')
def gd(b="""

		"""):
	if is_debug==1 and len(sys.argv)==1 :
		gdb.attach(io,b)
gift['io']=io



ia()
