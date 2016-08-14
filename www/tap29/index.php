<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>拨号服务器信息</title>
</head>

<body>
<div>
<p style="text-align: center;">
当前拨号IP信息
<?php
$adslip=`cat /tmp/tap29ip`;
echo $adslip;
?>

<br/>
<strong>用法：</strong>
直接单击下面的连接，系统会操作相应的进程，打开有点慢，因为是调用拨号程序，请耐心一点。

<br/><br/><br/><a href="reboot.php">重启拨号程序，一键换新IP </a>
<br/><br/><br/><a href="stop.php">用完后，请点击这里关闭拨号程序，防止多个会话在服务器，导致下次不能拨号 </a>
</p>
</div>
</body>
</html>
