FROM centos:6
MAINTAINER nattapon <lordhackalot@gmail.com>

ENV code_root /code
ENV httpd_conf ${code_root}/httpd.conf
ENV web_root ${code_root}/webroot

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum install -y httpd
RUN yum install --enablerepo=epel,remi-php56,remi -y \
                              php \
                              php-cli \
                              php-gd \
                              php-mbstring \
                              php-mcrypt \
                              php-mysqlnd \
                              php-pdo \
                              php-xml \
                              php-xdebug
RUN sed -i -e "s|^;date.timezone =.*$|date.timezone = Asia/Bangkok|" /etc/php.ini
RUN mkdir -p $code_root && curl -o $httpd_conf -SL http://172.24.1.17/httpd.conf
RUN mkdir -p $web_root && curl -o ${web_root}/index.html -SL http://172.24.1.17/first.txt
RUN test -e $httpd_conf && echo "Include $httpd_conf" >> /etc/httpd/conf/httpd.conf
RUN echo "Test > /tmp/test

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

