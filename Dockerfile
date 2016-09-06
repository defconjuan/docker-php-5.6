FROM dockerizedrupal/base-debian-jessie:1.1.0

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

LABEL vendor=dockerizedrupal.com

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

EXPOSE 9000 50022

RUN mkdir -p /var/run/sshd

# RUN /etc/init.d/ssh start #original, works on 5.5 to start PHP
# CMD ["/usr/sbin/sshd", "-D"] # to test, tested on .4 and didn't work

ENTRYPOINT ["/src/entrypoint.sh", "run"]
