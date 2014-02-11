import sys
#letter_frequency=[ ' ', 'e', 't', 'a', 'o', 'i', 'n', 's', 'h', 'r', 'd', 'l', 'c', 'u', 'm', 'w', 'f', 'g', 'y', 'p', 'b', 'v', 'k', 'j', 'x', 'q', 'z' ]
letter_frequency= [ ' ', 'e', 'a', 'r', 's', 't', 'n', 'i', 'o', 'l', 'd', 'c', 'u', 'p', 'm', 'h', 'g', 'y', 'f', 'b', 'w', 'v', 'k', 'x', 'z', 'j', 'q' ]

dic = {}
fh = open('take61.txt','r')
for line in fh.readlines():
	index = 0
	while index < len(line):
#		print 'coco'
		if line[index] == '.' or line[index] == ',' or line[index] == '-' or line[index] == '\'' or line[index] == '(' or line[index] == ')' or line[index].isdigit() :
#			print line[index]
			index += 1
			continue
#		print index, len(line)
		if line[index] == '\r':
#			print line[index:index+1]
			index += 2
			continue
		buf = line[index:index+3]
#		print buf
		if not dic.has_key(buf):
			dic[buf] = 1
		else:
			dic[buf] += 1
		index += 3
#		print index
fh.close()


table = {}
index = 0
for k ,v in sorted(dic.items(),key=lambda x:x[1],reverse=True) :
#	print k, dic[k]
	table[k] = letter_frequency[index]
	index += 1
#print len(dic)

#print table

fh = open('take61.txt','r')
for line in fh.readlines():
	index = 0
	while index < len(line):
		if line[index] == '.' or line[index] == ',' or line[index] == '-' or line[index] == '\'' or line[index] == '(' or line[index] == ')' or line[index].isdigit() :
			sys.stdout.write(line[index])
			index += 1
			continue
		if line[index] == '\r':
			sys.stdout.write(line[index:index+2])
			index += 2
			continue
		buf = line[index:index+3]
		sys.stdout.write(table[buf])
		index += 3
fh.close()
sys.stdout.write('\r\n')

content = 'bddsowntdntdtthnhynhjweoaaabtmntdaaatddbtbnhjsefbbdsetvsdweontd'
for index in range(0,len(content),3):
	code = content[index:index+3]
	if code == 'tdd' :
		sys.stdout.write('q')
	else:
		sys.stdout.write(table[code])
sys.stdout.write('\r\n')