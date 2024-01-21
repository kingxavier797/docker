# ------------------------------------------------------------------------------
# Dockerfile to build Oracle Linux container
# images based on Oracle Linux 8.2
# ------------------------------------------------------------------------------
FROM oraclelinux:8.2


RUN dnf install -y httpd
RUN dnf install -y sudo
RUN dnf install -y which
RUN dnf install -y perl


#RUN mkdir -p /var/www/cgi-bin
WORKDIR /var/www/cgi-bin
COPY preface.cgi preface.cgi
COPY counter.txt counter.txt
RUN chown apache:apache preface.cgi counter.txt
RUN chmod 755 preface.cgi

#RUN mkdir -p /etc/httpd/conf
WORKDIR /etc/httpd/conf
RUN echo "ServerName 172.0.0.1" >> httpd.conf

#  To avoid the error [ AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message


#RUN mkdir -p /var/www/html
WORKDIR /var/www/html
COPY copyright.txt copyright.txt
COPY *.html ./
COPY AndialySokone.jpg AndialySokone.jpg
COPY javapubscript.txt javapubscript.txt
RUN chown apache:apache *.html *.txt *.jpg 
COPY PUBIMG PUBIMG
RUN chown -R apache:apache PUBIMG



LABEL maintainer="asokone@thecloudedu.com" \
version="1.0"

EXPOSE 80

ENTRYPOINT /usr/sbin/httpd -D FOREGROUND

