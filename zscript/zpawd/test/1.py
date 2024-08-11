import multiprocessing
from time import sleep
def task(line):
	sleep(0.2)
	print(line.strip())

with open("./ip.txt",'r')as fp:
	lines=fp.readlines()
	for line in lines:
		task(line)
print("Done! ! !")


