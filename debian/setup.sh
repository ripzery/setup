#!/bin/sh

# Update apt packages

apt-get update

# Install VIM

if ! type "$vim" > /dev/null; then
  echo "######## Installing VIM... ########"
  echo "y" | apt-get install vim
fi

# Install Mosh server

## Enable firewall over UDP ports
echo "-A INPUT -p udp --dport 60000:61000 -j ACCEPT" > iptables.firewall.rules


