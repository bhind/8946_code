# -*- coding: utf-8 -*-
import sys
iv='123'
key='HACKZ'
keystream=list(iv+key)
#keystream=list('AAAAA')
#keystream=list('HHHHH')
#keystream=list('CCCCC')

arr_payload_buf=[ '7073720900020A1B',
'797A7B00090B0312' ,
'7271700B02000819' ,
'66776323243A0411' ]

for payload_buf in arr_payload_buf:
	payload = []
	for index in range(0,len(payload_buf),2):
		payload.append(int(payload_buf[index:index+2],16))
	ret = []
	index = 0
	for p in payload:
		ret.append(p^ord(keystream[index%len(keystream)]))
		index += 1
	for r in ret:
		sys.stdout.write(chr(r))
	sys.stdout.write('\n')
