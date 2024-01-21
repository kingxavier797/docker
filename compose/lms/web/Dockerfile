# ------------------------------------------------------------------------------
# Dockerfile to build Oracle Linux container
# images based on Oracle Linux 8.2
# ------------------------------------------------------------------------------
FROM oraclelinux:8.2


RUN dnf install -y httpd
RUN dnf install -y gcc
RUN dnf install -y tar
RUN dnf install -y sudo
RUN dnf install -y which
RUN dnf install -y net-tools hostname vim
RUN dnf install -y perl
RUN dnf install -y --skip-broken --nobest mysql*
RUN dnf install -y cpan
RUN cpan App:cpanminus
RUN sed -e 's/enabled=0/enabled=1/g' -i /etc/yum.repos.d/oracle-linux-ol8.repo /etc/yum.repos.d/uek-ol8.repo
RUN yum update -y
RUN yes | perl -MCPAN -e 'install DBI'
RUN yes | perl -MCPAN -e 'install DBD::mysql'

RUN mkdir -p /var/www
WORKDIR /var/www/
COPY docker_mailit_20200919.tgz docker_mailit_20200919.tgz
RUN tar zxvf docker_mailit_20200919.tgz 
RUN chown -R apache:apache html/mailit cgi-bin/mailit sql/mailit

WORKDIR /etc/httpd/conf
COPY ./conf/httpd.conf httpd.conf
RUN echo "ServerName 172.0.0.1" >> httpd.conf

#  To avoid the error [ AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message

WORKDIR /var/www/sql/mailit
#RUN ln -s /usr/bin/perl /usr/local/bin/perl
#CMD yes | ./doitall.ksh


LABEL maintainer="asokone@thecloudedu.com" \
version="1.0"

EXPOSE 80

ENTRYPOINT /usr/sbin/httpd -D FOREGROUND
