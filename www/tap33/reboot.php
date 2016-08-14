<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="refresh" content="15;url=index.php">
<title>重启拨号程序</title>
</head>
<body>
<div>
<p style="text-align: center;">
拨号服务进程重启中.....重新获得新IP，20秒钟返回拨号服务器信息页面

<br />
<?php

system("sudo /usr/bin/poff tap33 > /dev/null 2>&1");
sleep(16);
system("sudo /usr/bin/poff tap33 > /dev/null 2>&1");
sleep(2);
$num=system("sudo cat /tmp/pon.txt | grep tap33 | grep -v down | wc -l");
if ($num <= 10)
{
system("sudo /usr/bin/pon tap33 > /dev/null 2>&1");
}
else
{
system("sudo echo 今天超过连接数 >/tmp/tap33ip");
}
?>
</p>
</div>
</body>
</html>
