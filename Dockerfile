FROM dockerizedrupal/base-debian-jessie:1.1.0

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

LABEL vendor=dockerizedrupal.com

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

EXPOSE 9000 50022

RUN mkdir -p /var/run/sshd

# RUN /etc/init.d/ssh start # Works on 5.x thru 5.5 to start PHP, does not work on 5.6
# CMD ["/usr/sbin/sshd", "-D"] # Never used, more for testing

ENTRYPOINT ["/src/entrypoint.sh", "run"]
