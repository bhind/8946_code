<?php
if( $argc < 1 ) {
	die("引数に変換する文字列を指定してください");
}
$ref=ord("_")-ord("0");
$str=$argv[1];
$ret="";

for($i=0;$i<strlen($str);$i++) {
	if( $str[$i] == " " ) {
		$ret.=$str[$i];
		continue;
	}
	$buf=ord($str[$i])+$ref;
	if( $buf > 127 ) $buf = 33+($buf-127);
	$ret.=chr($buf);
}
print urlencode($ret)."\n";

