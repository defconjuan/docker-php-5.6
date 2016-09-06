#!/usr/bin/env bash

puppet apply --modulepath=/src/php-5.6/run/modules /src/php-5.6/run/run.pp

# uncomment following line if not using supervisor.d to auto-start ssh
# service ssh restart

supervisord -c /etc/supervisor/supervisord.conf
