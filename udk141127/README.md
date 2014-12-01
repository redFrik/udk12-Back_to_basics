141127
======

python experiments

either use <http://repl.it> or the terminal application.

python is good for writing little glue type of programs. that is communicate between different soft and hardware. one could also use max, pd, python, javascript etc, but python is very small and easy to learn + there are tons of libraries.

internet -> (python) -> supercollider
e.g. twitter -> (twython and osc library) -> supercollider

hid -> python -> supercollider
opencv -> python -> supercollider

supercollider -> python -> serial

```
#list
a= [10, 20, 30, 40, 50, 60]
print len(a)
=> 6
print a[2]
=> 30
print a[:2]
=> [10, 20]
print a[:-2]
=> [10, 20, 30, 40]
print a[3:]
=> [40, 50, 60]
print a[1:4]
=> [20, 30, 40]

a= [4.5, "a string", [1, 2, 3]]
a
=> [4.5, 'a string', [1, 2, 3]]
a.pop()
=> [1, 2, 3]
a.pop()
=> 'a string'
a.pop()
=> 4.5
a
=> []

a= [10, 20, 30]
len(a)
=> 3
a.__class__
=> <type 'list'>
a[0]
=> 10
a[:1]
=> [10]
a[:-1]
=> [10, 20]
a[1:]
=> [20, 30]
a[-1:]
=> [30]
a.append(500)
a
=> [10, 20, 30, 500]
a.remove(20)
a
=> [10, 30, 500]
a.pop()
=> 500
a= a+[22]
=> [10, 30, 22]
```

```
#dictionary
b= {'hello': 123, 'goodbye': 2}

print b['hello']
=> 123

b['my little list']= [88, 77, 66]
b
=> {'my little list': [88, 77, 66], 'hello': 123, 'goodbye': 2}

print b.keys()
=> ['my little list', 'hello', 'goodbye']

print b.values()
=> [[88, 77, 66], 123, 2]

a= {}
a['hello']= 123
a['goddbye']= 321
a.keys()
=> ['hello', 'goodbye']
a.values()
=> [123, 321]
```

```
#string
a= "kjahsdkjh"
"sd" in a
=> True
"sx" in a
=> False

"lkjkj"[0]
=> 'l'
"lkjkj"[0:3]
=> 'lkj'
"abcdefgh"[:2]
=> 'ab'
"abcdefgh"[:-2]
=> 'abcdef'
"abcdefgh"[-2:]
=> 'gh'
"lkjlkjlk".split("l")
=> ['', 'kj', 'kj', 'k']
len("ljkjh")
=> 5
"lkjlkjlk".count("j")
=> 2
"lkjhellolkj".find("hello")
=> 3
"lkjhellolkj".find("helo")
=> -1

"."*10
=> '..........'

a.replace("hello", "no")
=> 'kjahsdkjh'
"lkj  ljlkj".replace("l", "")
=> 'kj  jkj'
b= "http://www.google.de/search"
c= b.replace("http://", "")
c
=> 'www.google.de/search'

a= "my little pony"
a.title()
=> 'My Little Pony'
a.capitalize()
=> 'My little pony'
a.upper()
=> 'MY LITTLE PONY'
a.lower()
=> 'my little pony'
```

```
#iteration
for cnt in range(256):
    print chr(cnt)

a= "hello my name is ingvar"
for b in a:
    print b
```

```
a= ""
for cnt in range(30):
    for abc in range(10):
        a= a+chr(((abc+cnt)%5*2)+95)
    print a
    a= ""

a= "my little frog is sitting in the bathtub!"
for cnt in range(30):
    b= ""
    for abc in range(30):
        b= b+a[(cnt-abc)*4%len(a)]
    print b
```

```
cnt= 0
while cnt<100:
    i= 0
    a= ""
    while i<cnt:
        a= a+"."
        i= i+1
    print a
    cnt= cnt+2
```

```
#the below will not work in the online repl.it app
import time
time.localtime()
time.asctime(time.localtime())
time.sleep(1)

f= file("test.py", "r")
f.read()
f.close()

f= file("test.py", "r")
f.readline()
f.close()

dir(f)

f.seek(10)
f.read(1)
f.seek(20)
f.readline()

f= file('hheelloo.txt', 'w')
f.write('abcdef')
f.close()

import csv
f= file("csvv.txt", "w")
g= csv.writer(f)
g.writerow(a)
g.writerow(a)
f.close()

f= file("csvv.txt", "r")
g= csv.reader(f)
g.next()
g.next()
g.next()
f.close()

map(ord, "lkjlkj") #chr to int

chr(67) #int to chr

a= ""
for i in range(35):
    for j in range(255):
        a= a+chr((j+i)%256)
    print a
    a= ""

a.__class__

```

http://www.idiotinside.com/2014/09/04/string-processing-in-python/


save the below as frogs.py and then run it with `python frogs.py`. it will create a file called frogtest.txt with the resulting ascii graphics.
```
#!/usr/bin/python
f= file("frogtest.txt", "w")
a= "my little frog is sitting in the bathtub!"
for cnt in range(30):
    b= ""
    for abc in range(30):
        b= b+a[(cnt-abc)%len(a)]
    #print b
    f.write(b+"\n")
f.close()
```

save this as grogs.py
```
#!/usr/bin/python
a= "my little frog is sitting in the bathtub!"
for cnt in range(30):
    b= ""
    for abc in range(30):
        b= b+a[(cnt-abc)*4%len(a)]
    print b
```

then run the following in supercollider....
`"python /Users/Stirling/Desktop/grogs.py".unixCmd` #edit path to match your system
it should post the following in the post window.
```
mtbt t g tyuahiis ft btenniirl
imtbt t g tyuahiis ft btenniir
eimtbt t g tyuahiis ft btennii
oeimtbt t g tyuahiis ft btenni
soeimtbt t g tyuahiis ft btenn
tsoeimtbt t g tyuahiis ft bten
gtsoeimtbt t g tyuahiis ft bte
gtsoeimtbt t g tyuahiis ft bt
gtsoeimtbt t g tyuahiis ft b
h  gtsoeimtbt t g tyuahiis ft 
!h  gtsoeimtbt t g tyuahiis ft
l!h  gtsoeimtbt t g tyuahiis f
ll!h  gtsoeimtbt t g tyuahiis 
rll!h  gtsoeimtbt t g tyuahiis
irll!h  gtsoeimtbt t g tyuahii
iirll!h  gtsoeimtbt t g tyuahi
niirll!h  gtsoeimtbt t g tyuah
nniirll!h  gtsoeimtbt t g tyua
enniirll!h  gtsoeimtbt t g tyu
tenniirll!h  gtsoeimtbt t g ty
btenniirll!h  gtsoeimtbt t g t
btenniirll!h  gtsoeimtbt t g 
t btenniirll!h  gtsoeimtbt t g
ft btenniirll!h  gtsoeimtbt t 
ft btenniirll!h  gtsoeimtbt t
s ft btenniirll!h  gtsoeimtbt 
is ft btenniirll!h  gtsoeimtbt
iis ft btenniirll!h  gtsoeimtb
hiis ft btenniirll!h  gtsoeimt
ahiis ft btenniirll!h  gtsoeim
RESULT = 0
```

and to get the string into sc use this...
`a= "python /Users/Stirling/Desktop/grogs.py".unixCmdGetStdOut`
