<?php
// ああああ 5a60293ed94c172b4564f9c83b88ab40
if( $argc < 2 ) {
	die("invalid argument");
}
$hash = $argv[1];
$hiragana = Array();
$arrbuf = Array();
$arrbuf[0] = 0xE3;
$arrbuf[1] = 0x81;
for($i = 0x81; $i < 0xC0; $i++ ) {
	$arrbuf[2] = $i;
	$buf = "";
	foreach($arrbuf as $a) {
	    $buf .= chr($a);
	}
	array_push($hiragana,$buf);
}
$arrbuf[1] = 0x82;
for($i = 0x80; $i < 0x96; $i++ ) {
	$arrbuf[2] = $i;
	$buf = "";
	foreach($arrbuf as $a) {
	    $buf .= chr($a);
	}
	array_push($hiragana,$buf);
}

foreach($hiragana as $h1) {
	foreach($hiragana as $h2) {
		foreach($hiragana as $h3) {
			foreach($hiragana as $h4) {
				$strbuf = $h1.$h2.$h3.$h4;
				if( $hash == hash("md5",$strbuf) ) {
					print $strbuf."\n";
					die();
				}
			}
		}
	}
}