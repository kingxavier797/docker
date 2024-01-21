# ::::::::::::::::::::::
# Dockerfile.04
# ::::::::::::::::::::::

# Running Ubuntu Image on Docker

FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install python3

RUN mkdir /app
WORKDIR /app

COPY index.html index.html
COPY application.py application.py

COPY . .
LABEL maintainer="Andialy Sokone<asokone@thecloudedu.com>" \
version="1.0.1"

CMD python3 application.py
