<?php
//$buf="8946";
//$buf="ZKxk4h7n";
$buf="78155612011388331884595";
//$buf = hash("sha256", $buf);
for($i=0;$i<10000;$i++) $buf = hash("sha256", $buf);
echo $buf."\n";

