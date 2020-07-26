#!/bin/sh

print_header()
{
  echo ""
  echo "####### $1 #######"
  echo ""
}

# Update apt packages

print_header "Update apt packages..." 
apt-get update

# Setup Git identity

if ! git config user.email > /dev/null; then
  print_header "Setup Git Identity" 
  git config --global user.email "ripzery@gmail.com"
  git config --global user.name "euro"
fi

# Install VIM

if ! command -v vim > /dev/null; then
  print_header "Installing VIM..."
  yes | apt-get install vim
fi

# Install Mosh server

if ! command -v mosh > /dev/null; then
  ## Enable firewall over UDP ports
  echo "*filter" > /etc/iptables.firewall.rules
  echo "-A INPUT -p udp --dport 60000:61000 -j ACCEPT" >> /etc/iptables.firewall.rules
  echo "COMMIT" >> /etc/iptables.firewall.rules
  iptables-restore < /etc/iptables.firewall.rules

  ## Install Mosh
  print_header "Installing Mosh server..."
  yes | apt-get install software-properties-common
  add-apt-repository ppa:keithw/mosh
  yes | apt-get update
  yes | sudo apt-get install mosh
fi

