#!/usr/bin/env bash

puppet apply --modulepath=/src/php-5.6/run/modules /src/php-5.6/run/run.pp

service ssh restart #test
# exec /usr/sbin/sshd -D #test

supervisord -c /etc/supervisor/supervisord.conf
