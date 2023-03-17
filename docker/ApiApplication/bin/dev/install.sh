#!/usr/bin/env bash

set -e

apt-get update
apt-get install -y --force-yes openssh-server vim && \

pecl install xdebug-3.1.5

# install tools
apt-get install -y curl && \

# install node & npm
#curl -sL https://deb.nodesource.com/setup_8.x | bash && \
#apt-get install -y nodejs && \
#npm install -g swagger-cli && \

# SSH
mkdir /var/run/sshd && \
echo 'root:root' | chpasswd && \
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "export VISIBLE=now" >> /etc/profile && \
# SSH

cat $SRC_PATH/docker/ApiApplication/env_files/main.env >> /root/.bashrc
echo 'export TERM=xterm' >> /root/.bashrc
