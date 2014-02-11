require 'base64'
require 'cgi'

cmd='print'
#arg='48;'
arg='get_pass();'
ret=''
cmd.each_char { |c| ret+=(c.ord+5).chr }
ret+=' '
#arg.each_char { |c| ret+=(c.ord+5).chr }
'get'.each_char { |c| ret+=(c.ord+5).chr }
ret+='_'
'pass'.each_char { |c| ret+=(c.ord+5).chr }
ret+='();'
p ret
p CGI.escape(Base64.encode64(ret))
 

