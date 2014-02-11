# -*- coding: utf-8 -*-
import sys
import io
import math
# sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
if( len(sys.argv) < 2 ):
	sys.exit("invalid argument")

target_count = int(sys.argv[1]);
if( target_count < 1 ):
	sys.exit("invalid argument")

primes = []
primes.append(2)
if( target_count > 1 ):
	primes.append(3)
	if( target_count > 2):
		index = 5
		while(len(primes) < target_count) :
			max = math.floor(math.sqrt(index))
			for i in range(1,len(primes)):
				if( primes[i] > max ):
					primes.append(index)
					break
				if( index % primes[i] == 0 ):
					break
			index += 2
for p in primes:
	print(p)

