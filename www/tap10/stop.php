<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="refresh" content="5;url=index.php">
<title>断开拨号程序</title>
</head>
<body>
<div>
<p style="text-align: center;">
拨号服务进程关闭中.....5秒钟返回拨号服务器信息页面

<br />
<?php

system("sudo /usr/bin/poff tap10 > /dev/null 2>&1");
?>
</p>
</div>
</body>
</html>
