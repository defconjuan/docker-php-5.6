#!/usr/bin/env bash

# apt-get update
apt-get install -y openssh-server

sed -i 's/Port 22/\# Defcon edits\: \
\Port 22 \# original\
 Port 50022/g' /etc/ssh/sshd_config

puppet apply --modulepath=/src/php-5.6/build/modules /src/php-5.6/build/build.pp

# update-rc.d ssh defaults #Next load SSH defaults to run level
# Enable ssh socket
systemctl enable ssh.socket
# Uncomment following lines if not using supervisor.d to auto-start ssh
# First of all remove run levels for SSH
# update-rc.d -f ssh remove
# update-rc.d -f ssh enable 2 3 4 5

echo -e "container\ncontainer" | passwd container
