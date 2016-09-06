FROM dockerizedrupal/base-debian-jessie:1.1.0

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

LABEL vendor=dockerizedrupal.com

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

EXPOSE 9000 50022

RUN mkdir -p /var/run/sshd
#RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
#  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
#  && touch /root/.Xauthority \
#  && true

# RUN /etc/init.d/ssh start # Works on 5.x thru 5.5 to start PHP, does not work on 5.6
# CMD ["/usr/sbin/sshd", "-D"] # Never used, more for testing

ENTRYPOINT ["/src/entrypoint.sh", "run"]
