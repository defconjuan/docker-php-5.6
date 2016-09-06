#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/php-5.6/build.sh && /src/php-5.6/clean.sh"
    ;;
  run)
    # /bin/su - root -mc "service ssh restart"
    /bin/su - root -mc "source /src/php-5.6/variables.sh && /src/php-5.6/run.sh"
    # /bin/su - root -mc "source /src/php-5.6/variables.sh && /src/php-5.6/run.sh && exec /usr/sbin/sshd -D"
    # /bin/su - root -mc "source /src/php-5.6/variables.sh && /src/php-5.6/run.sh && service ssh restart && true"
    ;;
esac
