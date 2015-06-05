FROM registry.wpython.com/centos:6.6

MAINTAINER xuqiangqiang "739827282@qq.com"

RUN yum -y install gcc gcc-c++ gcc-g77 make libtool autoconf patch unzip automake libxml2 libxml2-devel ncurses ncurses-devel libtool-ltdl-devel libtool-ltdl libmcrypt libmcrypt-devel libpng libpng-devel libjpeg-devel openssl openssl-devel curl curl-devel libxml2 libxml2-devel ncurses ncurses-devel libtool-ltdl-devel libtool-ltdl autoconf automake libaio* tar lrzsz  supervisor

RUN mkdir -p /var/log/supervisor

ADD ./supervisord.conf            /etc/supervisord.conf
ADD ./install_env.sh 		  /root/tools/php/install_env.sh
ADD ./update_openssl.sh		  /root/tools/php/update_openssl.sh
ADD ./php-5.6.9.tar.gz		  /root/tools/php/
ADD ./openssl-1.0.1h.tar.gz  	  /root/tools/php/
ADD ./install_nginx_php-5.6.9.sh  /root/tools/php/install_nginx_php-5.6.9.sh
ADD ./install_php_extension.sh    /root/tools/php/install_php_extension.sh


WORKDIR /root/tools/php/

RUN mkdir -p /data/log/php/
RUN sh install_env.sh
RUN sh install_nginx_php-5.6.9.sh
RUN sh update_openssl.sh
RUN sh install_php_extension.sh

#RUN rm -rf /root/tools/php/

EXPOSE 22 9000

CMD ["/usr/bin/supervisord"]
