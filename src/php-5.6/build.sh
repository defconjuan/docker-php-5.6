#!/usr/bin/env bash

# apt-get update
apt-get install -y openssh-server

sed -i 's/Port 22/\# Defcon edits\: \
\Port 22 \# original\
 Port 50022/g' /etc/ssh/sshd_config

puppet apply --modulepath=/src/php-5.6/build/modules /src/php-5.6/build/build.pp

# update-rc.d -f ssh remove #First of all remove run levels for SSH.
# The next line and the one line on the Docker file are enought to auto-start SSH on php 5.5, but not 5.6
# update-rc.d ssh defaults #Next load SSH defaults to run level

# Something to try
systemctl enable ssh.socket
update-rc.d -f ssh remove #First of all remove run levels for SSH.
update-rc.d -f ssh enable 2 3 4 5

echo -e "container\ncontainer" | passwd container
