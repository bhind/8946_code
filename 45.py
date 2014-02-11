# -*- coding: utf-8 -*-
import sys
iv='123'
key='88946'
keystream=list(iv+key)

payload_buf='3132336F514B5152'
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