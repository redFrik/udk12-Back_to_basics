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
print a[2]
print a[:2]
print a[:-2]
print a[3:]
print a[1:4]

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
a.__class__
len(a)
a[0]
a[:1]
a[:-1]
a[1:]
a[-1:]
a.append(500)
a.remove(20)
a.pop()
a= a+[22]
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
a.values()

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
"abcdefgh"[:2]
"abcdefgh"[:-2]
"abcdefgh"[-2:]
"lkjlkjlk".split("l")
len("ljkjh")
"lkjlkjlk".count("j")
"lkjhellolkj".find("helo")

"."*10

a.replace("hello", "no")
"lkj  ljlkj".replace("l", "")
b= "http://www.google.de/search"
c= b.replace("http://", "")

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


save this as frogs.py and then run it with ´python frogs.py´
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
