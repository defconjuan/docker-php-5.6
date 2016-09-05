FROM dockerizedrupal/base-debian-jessie:1.1.0

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

LABEL vendor=dockerizedrupal.com

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

RUN mkdir -p /var/run/sshd
#RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
#  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
#  && touch /root/.Xauthority \
#  && true

EXPOSE 9000 50022

# RUN /etc/init.d/ssh start #original
# CMD ["/usr/sbin/sshd", "-D"] # to test


ENTRYPOINT ["/src/entrypoint.sh", "run"]
