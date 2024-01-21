# ------------------------------------------------------------------------------
# Dockerfile to build Oracle Linux container
# images based on Oracle Linux 8.2
# ------------------------------------------------------------------------------
FROM oraclelinux:8.2

RUN dnf install -y nodejs
# With Node.js you can build complex single-page apps, chat rooms, data streaming apps, browser games and even do hardware programming.


WORKDIR /
COPY hello-world.js hello-world.js

LABEL maintainer="asokone@thecloudedu.com" \
version="1.0"

EXPOSE 3000
CMD ["node", "/hello-world.js"]
