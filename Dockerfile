FROM lihaixin/sshd
MAINTAINER Haixin Lee <docker@lihaixin.name>
ENV TZ "Asia/Chongqing"
ENV S5_PW "test123"
ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     61080
ENV PASSWORD        pwd
ENV METHOD          none
ENV PROTOCOL        auth_chain_b
ENV PROTOCOLPARAM   1
ENV OBFS            tls1.2_ticket_auth
ENV TIMEOUT         300
ENV speed_limit_per_con 300

ARG BRANCH=manyuser
ARG WORK=~

# 配置时区
# RUN   echo $TZ > /etc/timezone && \
#           cp -f /usr/share/zoneinfo/$TZ /etc/localtime

#安装pptp客户端拨号程序
RUN    apt-get update -y  && apt-get install -y --no-install-recommends pptp-linux
COPY chap-secrets /etc/ppp/chap-secrets
COPY options.pptp  /etc/ppp/options.pptp
COPY tap1 /etc/ppp/peers/tap1
COPY ip-up /etc/ppp/ip-up
COPY ip-down /etc/ppp/ip-down
RUN chmod +x /etc/ppp/ip-up
RUN chmod +x /etc/ppp/ip-down

#安装在线重启web服务器
RUN apt-get install -y --no-install-recommends apache2 php7.0 libapache2-mod-php7.0 curl lynx sudo dnsutils iptables && \
 echo 'www-data ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY www /var/www
COPY mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf



#安装shadowsocks #禁止未拨号通过
RUN apt-get install -y python-pip python-m2crypto && \
           mkdir -p $WORK && \
           wget -qO- --no-check-certificate https://github.com/shadowsocksr-backup/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK
           useradd -m tap1 && \
           echo tap1:tap1 | chpasswd
           
WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks

RUN ln -s server.py httpd-server.py

        

## 现在每天拨号次数
RUN apt-get install cron && \
echo '0 1 * * * /bin/mv /tmp/pon.txt /tmp/pon.txt.bak' >>/var/spool/cron/crontabs/root && \
chown root:crontab /var/spool/cron/crontabs/root && \
chmod 600 /var/spool/cron/crontabs/root



# 升级到最新版本 删除不必要的软件和Apt缓存包列表
RUN  apt-get upgrade --yes && \
         apt-get autoclean && \
         apt-get autoremove && \
         rm -rf /var/lib/apt/lists/*

# 开放shadowsocks端口
EXPOSE 1080

# 容器里超级进程管理
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY myrun /usr/bin/myrun
RUN  chmod +x /usr/bin/myrun


# 运行各种Service
CMD ["/usr/bin/supervisord"]
