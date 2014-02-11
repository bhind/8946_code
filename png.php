<?php
$sz = getimagesize("take29_wh.png");
$im = imagecreatefrompng("take29_wh.png");

if(!($dest_handle = fopen("out.dat", "wb"))) {
	die("file error");
}
for($y = 0; $y < $sz[1]; $y++) {
	for($x = 0; $x < $sz[0]; $x++) {
		$rgb = imagecolorat($im, $x, $y);
		$colors = imagecolorsforindex($im, $rgb);
		// 取得したアルファチャンネルの値が想定とちがう。。。
		print dechex($colors["alpha"]);
		fwrite($dest_handle, chr($colors["alpha"]), 1);
	}
}
fclose($dest_handle);

