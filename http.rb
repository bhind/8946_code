#!/usr/bin/ruby
# encoding: utf-8
require 'rubygems'
require 'mechanize'
require 'kconv'

sesid = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

regexp = Regexp.compile('<div id="question">(.+)</div>')
headers = 
{'Accept'=>'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
'Origin'=>'http://www.hackerschool.jp',
'Content-Type'=>'application/x-www-form-urlencoded',
'User-Agent'=>'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36',
'Referer'=>'http://www.hackerschool.jp/hack/take32.php',
'Accept-Encoding'=>'sdch',
'Accept-Language'=>'ja,en-US;q=0.8,en;q=0.6',
'Cookie'=>'PHPSESSID='+sesid+';'
};
uri = 'http://www.hackerschool.jp/hack/take32.php';
_uri = URI.parse(uri)
agent = Mechanize.new
cookie_string = 'PHPSESSID='+sesid+'; domain=www.hackerschool.jp; expires=Thursday, 14-Oct-#{Time.new.year+1} 13:20:05 GMT; path=/'
Mechanize::Cookie.parse(_uri, cookie_string){|cookie|
  agent.cookie_jar.add(_uri, cookie)
}
agent.max_file_buffer = 4611686018427388000
page = agent.get(uri, headers=headers)
puts page.code
if page.code == '200' then
	sttm = Time.now
	data = page.at('#question')
	regexp.match(data.to_s)
	buf = $1
	arrbuf = buf.split('x');
	answer = 1
	for elm in arrbuf do
		answer *= Integer(elm.strip)
	end
	for index in 1...1000 do
		form = page.form_with(:name=>'form1')
		form.field_with(:name=>'input_id').value=answer.to_s
		button = form.button_with(:value=>'送信！')
		page = agent.submit(form,button)
		if page.code == '200' then
			edtm = Time.now
#			puts page.body
			puts '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-'
			puts page.at('.control-group')
			puts (edtm - sttm).to_s
			puts answer

			sttm = Time.now
			data = page.at('#question')
			regexp.match(data.to_s)
			buf = $1
			arrbuf = buf.split('x');
			answer = 1
			for elm in arrbuf do
				answer *= Integer(elm.strip)
			end
		end
	end
end
