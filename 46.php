<?php
 	@error_reporting(0);
//	$ans=$_POST['input_id'];
// 	$ans=$argv[1];
$ans=array('0000000000','000000000000');
	if(substr(md5($ans),0,10)=="0"){
		print "OK";
	}else{
		print "NG";
	}
 
