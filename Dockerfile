FROM alpine:3.2

MAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>

RUN mkdir /root/.ssh && echo > /root/.ssh/authorized_keys

RUN apk update && \
    apk add bash git openssh rsync

RUN rc-update add sshd && \
    rc-status && \
    touch /run/openrc/softlevel && \
    /etc/init.d/sshd start && \
    /etc/init.d/sshd stop

RUN echo 'root:changeme' | chpasswd

COPY files/.bashrc /root/.bashrc
COPY files/sshd_config /etc/ssh/sshd_config

EXPOSE 22


ENTRYPOINT ["/bin/bash"]
