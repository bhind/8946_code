ADFGVX = ['A','D','F','G','V','X']

keystring = 'hackerschool'

targetcode = 'GGAGAXVAGGVAGAVAFAGGFGVAAFGAGAGGGDFAAGAGDADVFGAXAAFAGD'

def get_keysequence(keystring)
	keysequence = []
	keysequence_buf = []
	for index in 0...keystring.length
		k = keystring[index]
		if !keysequence_buf.include?(k) then
			keysequence_buf.push(k)
		end
	end
	keysequence_sort = keysequence_buf.sort
	for k in keysequence_sort do
		keysequence.push(keysequence_buf.index(k))
	end
=begin
	for k in keysequence_buf do
		keysequence.push(keysequence_sort.index(k))
	end
=end
	return keysequence
end
def change_sequence(keysequence, code)
=begin
	offset = 0
	p code
	retcode = []
	for index in 0...code.length
		# out[index]=in[offset+keysequence[index%l]
		if index != 0 && index % keysequence.length == 0 then
			offset += keysequence.length
		end
		retcode[offset+keysequence[index%keysequence.length]] = code[index]
		#retcode[offset+keysequence.index(index%keysequence.length)] = code[index]
	end
	p retcode
	return retcode
=end
	offset = 0
	p code
	lines = (code.length / keysequence.length).floor
	modulo = code.length % keysequence.length
	bufarr = []
	bufstr = ''
	cntr = 0
	for index in 0...code.length
		bufstr += code[index]
		if (cntr == lines-1 && keysequence[offset] >= modulo) || cntr >= lines then
			cntr = 0
			#bufarr[keysequence.index(offset)] = bufstr
			bufarr[keysequence[offset]] = bufstr
			bufstr = ''
			offset += 1
			next
		end
		cntr += 1
	end
	retcode = ''
	for index in 0...lines
		for k_index in 0...keysequence.length
			retcode += bufarr[k_index][index]
		end
	end
	p retcode
	return retcode
end
def fill_table(table,keysequence,sample_plain,sample_code)
	plain_index = 0
	offset = 0
	convertedstringbuf = change_sequence(keysequence,sample_code)
	for index in 0.step(convertedstringbuf.length-1,2) do
		fore = convertedstringbuf[index]
		back = convertedstringbuf[index+1]
		table[ADFGVX.index(fore)][ADFGVX.index(back)] = sample_plain[plain_index]
p sample_plain[plain_index]+':'+fore+','+back
		plain_index+=1
	end
end
def decode(table, keysequence, code)
	resstring = '';
	convertedstringbuf = change_sequence(keysequence,code)
	for index in 0.step(convertedstringbuf.length-1,2) do
		fore = convertedstringbuf[index]
		back = convertedstringbuf[index+1]
		# 換字表が完成したら、X軸＝＞Y軸で読み取り。
		bufchar = table[ADFGVX.index(back)][ADFGVX.index(fore)]
		if bufchar == nil then
			bufchar = '*'
		end
		resstring += bufchar
	end
	return resstring
end

keysequence = get_keysequence(keystring)
p keysequence

table = Array.new(ADFGVX.length).map! { Array.new }

fill_table(table, keysequence, 'whitehackerzTo8946', 'VDAXDGGGAFFVVAVAGAFXVXAAVDVXVFFVFXFG')
fill_table(table, keysequence, 'abcdelmnos12345678', 'FFGVGDGXFVVAAAAGDGXXVAVGXAFXXGDXAGVD')
p table
p decode(table, keysequence, targetcode)