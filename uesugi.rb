# -*- encoding: utf-8 -*-
iroha='いろはにほへとちりぬるをわかよたれそつねならむうゐのおくやまけふこえてあさきゆめみしゑひもせすん'
table = Array.new(7).map! { Array.new }
row = 0
for index in 0...iroha.length
	if index != 0 && index % 7 == 0 then
		row += 1
	end
	table[row][index%7]=iroha[index]
end

# もののふの鎧の袖をかたしきて
key1 = 'まくらにちかき'
key2 = 'はつかりのこゑ'

string1 = 'くこらかにのちかかゑきこ'
string2 = 'にのらゑくのきかにかきり'

res = ''
for index in 0.step(string1.length-1,2) do
	string1_index = key1.index(string1[index])
	string2_index = key2.index(string1[index+1])
	buf = table[string1_index][string2_index]
	res += buf
end
for index in 0.step(string2.length-1,2) do
	string1_index = key1.index(string2[index])
	string2_index = key2.index(string2[index+1])
	buf = table[string1_index][string2_index]
	res += buf
end
p res
