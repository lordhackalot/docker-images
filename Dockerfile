FROM centos:6
MAINTAINER nattapon <lordhackalot@gmail.com>

#RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
#RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
#RUN sed -i -e "s|^;date.timezone =.*$|date.timezone = Asia/Bangkok|" /etc/php.ini

RUN yum install -y sudo tar libcurl-devel gcc
RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers
RUN ulimit -n 65536

ENV root_tmp /root/tmp
RUN mkdir -p $root_tmp && curl -o ${root_tmp}/td-agent-2.1.5-1.x86_64.rpm -SL http://52.74.40.153/fluentd/td-agent-2.1.5-1.x86_64.rpm
RUN curl -o ${root_tmp}/td-agent.conf -SL http://52.74.40.153/fluentd/td-agent.conf
RUN curl -o ${root_tmp}/Python-2.7.6.tar.xz -SL http://52.74.40.153/fluentd/Python-2.7.6.tar.xz
RUN curl -o ${root_tmp}/run.sh -SL http://52.74.40.153/fluentd/run.sh
RUN ls -l  ${root_tmp}/
#RUN yum localinstall -y ${root_tmp}/td-agent-2.1.5-1.x86_64.rpm
#RUN cp /etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf.orig && cp -f ${root_tmp}/td-agent.conf /etc/td-agent/
RUN ln -s /usr/bin/gcc /usr/bin/gcc44

#RUN /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch
#RUN /usr/sbin/td-agent-gem install fluent-plugin-format
#RUN /usr/sbin/td-agent-gem install  fluent-plugin-woothee
#RUN /usr/sbin/td-agent-gem install fluent-plugin-geoip -v 0.4.0
#RUN /usr/sbin/td-agent-gem install fluent-plugin-forest
#RUN /usr/sbin/td-agent-gem install fluent-plugin-record_reformer

#EXPOSE 24224
#ENTRYPOINT ["/bin/bash", "${root_tmp}/run.sh"]


