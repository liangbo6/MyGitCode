#!/usr/bin/python3
# -*- coding: utf-8 -*-
import requests
import multiprocessing
from pwn import *
import re
#from pwncli import *
#from LibcSearcher import *
#import base64
#import hashlib
file_name=''
libc=ELF('')
e=ELF(file_name)
#context.log_level='debug'
context.arch='amd64'
#warnings.filterwarnings("ignore", category=BytesWarning)
IP_FILE='./ip.txt'
WAIT_TIME=5

s = lambda x: io.send(x)
sl = lambda x: io.sendline(x)
sa =lambda x,y: io.sendafter(x,y)
sla = lambda x, y: io.sendlineafter(x, y)
r = lambda: io.recv()
rl = lambda: io.recvline()
rn = lambda x: io.recvn(x)
ru = lambda x,drop=False: io.recvuntil(x,drop)
ia = lambda : io.interactive()
ls = lambda value,s='' : log.success("\033[34m"+s+"\033[0m"+"\033[35m=======>\033[0m"+"\033[33m"+value+"\033[0m")
li = lambda value : log.info("\033[32m"+value+"\033[0m")
lw = lambda value : log.warning("\033[31m"+value+"\033[0m")
l64 = lambda : u64(io.recvuntil(b"\x7f")[-6:].ljust(8,b"\x00"))
l32 = lambda : u32(io.recvuntil(b"\xf7")[-4:].ljust(4,b"\x00"))

def submit(ip,flag, token):
	url = "wangzhi"
	pos = {
		"flag":flag,
		"token":token,
		"ip":ip	
	}

	print("[+] Submiting flag : [%s]" % (pos))
	response = requests.post(url,data=data)
	content = response.content
	print("[+] Content : %s " % (content))
	if failed in content:
		lw("failed")
		return False
	else:
		li("Success!")
		return True
#gift['io']=io
def exp():


def task(line):
		l=line.strip().split(':')
		ip=l[0]
		port=l[1]
		try:
			global io
			io=remote(ip,port)
			exp()
			sl('cat flag')
			fl=re.findall("flag{.*}",r().decode())
			li(ip+":"+str(port)+" get flag successfully!")
			io.close()
			print(fl)

			res=submit(ip,fl,token)
			if res == True:
				li(ip+":"+str(port)+" submit flag successfully!")
				success_flag+=1
			else:
				lw(ip+":"+str(port)+" submit flag failed!")
		except Exception as error:
			lw(ip+":"+str(port)+" can't get flag! ! !")
			print(error)

if __name__=="__main__":
	while 1:

		success_flag=0
		with open("./ip.txt",'r')as fp:
			line=fp.readline()
			while line:
				process_list=[]
				for i in range(4):
					p=multiprocessing.Process(target=task,args=(line,))
					p.start()
					process_list.append(p)
					line=fp.readline()
					if line == '':
						break
				for p in process_list:
					p.join()


		li("{} flags were successfully submitted!".format(success_flag))
		sleep(WAIT_TIME)
