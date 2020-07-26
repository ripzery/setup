#!/bin/sh

# Update apt packages

apt-get update

# Setup Git identity

if ! git config user.email > /dev/null; then
  echo "####### Setup Git Identity ########"
  git config --global user.email "ripzery@gmail.com"
  git config --global user.name "euro"
fi

# Install VIM

if ! command -v vim > /dev/null; then
  echo "######## Installing VIM... ########"
  echo "y" | apt-get install vim
fi

# Install Mosh server

## Enable firewall over UDP ports
echo "-A INPUT -p udp --dport 60000:61000 -j ACCEPT" > /etc/iptables.firewall.rules


