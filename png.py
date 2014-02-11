import Image
import sys
img = Image.open('take29_wh.png')
px = img.load()
for y in range(0,img.size[1]):
	for x in range(0,img.size[0]):
		alpha = px[x,y][3]
		sys.stdout.write(chr(alpha))
