import multiprocessing
from time import sleep
def task(line):
	sleep(0.2)
	print(line.strip())

#with open("./ip.txt",'r')as fp:
#	lines=fp.readlines()
#	for line in lines:
#		task(line)
#print("Done! ! !")

with open("./ip.txt",'r')as fp:
	line=fp.readline()
	while line:
		process_list=[]
		for i in range(4):
			p=multiprocessing.Process(target=task,args=(line,))
			line=fp.readline()
			if line == '':
				print("hahaha")
				break
			p.start()
			process_list.append(p)
		for p in process_list:
			p.join()
		print(process_list)
	


print("Done! ! !")
