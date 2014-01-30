FROM ubuntu:12.04
MAINTAINER Hans Donner <hans.donner@pobox.com>

ENV DEBIAN_FRONTEND noninteractive

# everything up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y# everything up to date

# install haproxy
RUN apt-get install -y haproxy

# add scripts and install dependencies
RUN mkdir /docker
ADD scripts /docker/scripts
RUN chmod +x /docker/scripts/*

# config via volume
RUN mv /etc/haproxy /etc/haproxy.def
VOLUME /etc/haproxy

# expose ports
EXPOSE 80 8080 22 9000

# entrypoint
ENTRYPOINT ["/docker/scripts/start"]
