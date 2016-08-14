#介绍

配置pptp拨号程序，然后通过shadowsocke访问，然后通过页面重启pptp

#用法

	docker run -itd --restart=always --privileged --name tap6001 -p 6001:1080 lihaixin/pptp
	docker exec -it tap6004 /bin/bash

#高级用法

	docker run -itd --restart=always --privileged -e S5_PW=PASSWORD --name tap6001 -p 6001:1080 lihaixin/pptp
