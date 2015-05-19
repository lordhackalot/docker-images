FROM centos:centos6
MAINTAINER nattapon <lordhackalot@gmail.com>
ENV KIBANA_CONFIG /opt/kibana/config/kibana.yml
ENV fileshared 172.24.1.17
RUN \
    yum update -y && \
    yum install -y tar java-1.7.0-openjdk && \
    yum clean all && \
    mkdir -p /opt/kibana && \
    cd /opt/kibana && \
    curl -o /tmp/kibana4.tgz http://${fileshared}/kibana/kibana-4.0.2-linux-x64.tar.gz && \
    tar zxvf /tmp/kibana4.tgz -C /opt/kibana --strip-components=1 && \
    rm -f /tmp/kibana4.tgz
RUN curl -o  /bootstrap.sh -SL http://${fileshared}/kibana/bootstrap.sh
#COPY bootstrap.sh /
EXPOSE 5601
ENTRYPOINT ["/bootstrap.sh"]
