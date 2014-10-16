import math
import time
i= 0
while i<200:
	j= int(math.sin(i*0.05)*30+30)
	str= ''
	while j>0:
		str= str+'*'
		j= j-1
	print str
	i= i+1
	time.sleep(0.05)

