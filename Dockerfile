FROM ubuntu:12.04
MAINTAINER Hans Donner <hans.donner@pobox.com>

ENV DEBIAN_FRONTEND noninteractive

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list \

# everything up to date
RUN apt-get update && apt-get upgrade -y

# install haproxy
RUN apt-get install -y haproxy

# move default config
RUN mv /etc/haproxy /etc/haproxy.def

# provide config via volume
VOLUME /etc/haproxy

# expose ports for haproxy
EXPOSE 80 8080 22 9000

# start script
ADD start.sh start
RUN chmod +x start
ENTRYPOINT ["./start"]
