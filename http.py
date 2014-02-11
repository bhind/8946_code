import urllib
import httplib
import re
import StringIO
import sys
import time

sesid = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

regexp = re.compile(r'<div id="question">(.+)</div>')
regexp_h = re.compile(r'<input type="hidden" name="h_timestamp" value="(.+)" />')
regexp_i = re.compile(r'<input type="hidden" name="i_timestamp" value="(.+)" />')
headers = {
'Content-Type':'application/x-www-form-urlencoded',
'Cookie':'PHPSESSID='+sesid+';'
};

connection = httplib.HTTPConnection('www.hackerschool.jp')
#connection = httplib.HTTPConnection('1.33.188.154')
sttm0 = time.time()
connection.request('GET','/hack/take32.php',None,headers)
sttm1 = time.time()
response = connection.getresponse();
sttm2 = time.time()
print response.status,response.reason
if response.status == 200:
	data = response.read()
	res = regexp.search(data)
	res_h = regexp_h.search(data)
	res_i = regexp_i.search(data)
	arr = res.group(1).split("x")
	answer = 1;
	for elm in arr:
		answer = answer * int(elm.strip())
	edtm = time.time()
	connection.close()
	connection2 = httplib.HTTPConnection('www.hackerschool.jp')
	#connection2 = httplib.HTTPConnection('1.33.188.154')
	#connection2 = httplib.HTTPConnection('localhost',8080)
	for index in range(100):
		sttm0 = time.time()
		connection2.request('POST','/hack/take32.php','h_timestamp='+res_h.group(1)+'&i_timestamp='+res_i.group(1)+'&input_id='+str(answer),headers)
		#connection2.request('POST','http://www.hackerschool.jp/hack/take32.php','h_timestamp='+res_h.group(1)+'&i_timestamp='+res_i.group(1)+'&input_id='+str(answer),headers)
		sttm1 = time.time()
		response = connection2.getresponse();
		edtm = time.time()
		print response.status,response.reason
		if response.status == 200:
			data = response.read()
			res = regexp.search(data)
			res_h = regexp_h.search(data)
			res_i = regexp_i.search(data)
			arr = res.group(1).split("x")
			answer = 1;
			for elm in arr:
				answer = answer * int(elm.strip())
			edtm = time.time()
			#data = response.read()
			print data
			buf = StringIO.StringIO(data)
			print '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-'
			lines = buf.readlines()
			showcount = 0
			for ln in lines:
				if ln.find('<div class="control-group ">') >= 0:
					showcount = 10
				if showcount > 0:
					sys.stdout.write(ln)
					showcount = showcount - 1
			# print res.group(1) + ',' + res_h.group(1) + ','  + res_i.group(1)
			#connection2.close()
			print str(edtm - sttm0)
			print str(edtm - sttm1)
			# time.sleep(1)
	
