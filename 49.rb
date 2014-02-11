# -*- encoding: utf-8 -*-
$password_prefix='tanaka'
$salt='8946'
$hash='89B1pK00C26w6'
def checkhash(s)
    ans = s.crypt($salt)
    if(ans==$hash)
        p s
	abort()
    end 
end
(0x20...0x7e).each {|ch| 
    s = ch.chr
    (0x20...0x7e).each {|ch2| 
        s2 = ch2.chr
        psw = $password_prefix+s+s2
        checkhash(psw)
    }
}
