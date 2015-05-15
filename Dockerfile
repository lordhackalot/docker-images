FROM centos:6
MAINTAINER nattapon <lordhackalot@gmail.com>

#RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
#RUN sed -i -e "s|^;date.timezone =.*$|date.timezone = Asia/Bangkok|" /etc/php.ini
#RUN rpm -i http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-11.ius.centos6.noarch.rpm

ENV root_tmp /root/tmp
RUN curl -o /etc/yum.repos.d/elasticsearch.repo -sSL http://52.74.40.153/elasticsearch/elasticsearch.repo
RUN mkdir -p $root_tmp && curl -o ${root_tmp}/elasticsearch.sysconfig -SL http://52.74.40.153/elasticsearch/elasticsearch.sysconfig
RUN curl -o ${root_tmp}/elasticsearch.yml -SL http://52.74.40.153/elasticsearch/elasticsearch.yml
RUN curl -o ${root_tmp}/run.sh -SL http://52.74.40.153/elasticsearch/run.sh

RUN rpm -i http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y which sudo tar gcc libcurl-devel java-1.7.0-openjdk java-1.7.0-openjdk-devel elasticsearch
RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers
RUN ulimit -n 65536
RUN cp ${root_tmp}/elasticsearch.sysconfig /etc/sysconfig/elasticsearch && cp -f ${root_tmp}/elasticsearch.yml  /etc/elasticsearch/elasticsearch.yml
#RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest
#RUN /sbin/sysctl -w 'vm.swappiness=1'

EXPOSE 9200
EXPOSE 9300
EXPOSE 5601

#ENTRYPOINT ["/bin/bash", "/root/tmp/run.sh"]

