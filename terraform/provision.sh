#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install requirements to manage from ansible
apt-get -qq update
apt-get -qq install --no-install-recommends -y python3 git rsync
apt-get clean

# install ansible ssh public key to grant ssh access from ansible admin hosts
cat /tmp/ansible-node.pub >> /home/ubuntu/.ssh/authorized_keys

# install ansible github private key to grant access to GitHub from ansistrano role
mv /tmp/gitHubKey /root/.ssh/gitHubKey
chmod 400 /root/.ssh/gitHubKey
echo "IdentityFile ~/.ssh/gitHubKey" >> /root/.ssh/config
chmod 600 /root/.ssh/config