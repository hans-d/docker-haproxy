# Autogenerated - do not edit
FROM hansd/base:latest
MAINTAINER Hans Donner <hans.donner@pobox.com> "https://github.com/hans-d"

RUN apt-get install -y haproxy
RUN apt-get install -y incron
RUN mv /etc/haproxy /etc/haproxy.def && \
    mkdir -p /etc/haproxy/conf.d

RUN mkdir -p /docker/scripts /docker/templates
ADD common/scripts /docker/scripts

ADD etc /etc

ADD scripts /docker/scripts
RUN chmod +x /docker/scripts/*

RUN chmod +x --recursive /etc/my_init.d/* /etc/service/*

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 80 8080 9000 443

