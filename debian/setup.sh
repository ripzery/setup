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
  apt-get install -y vim
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
  apt-get install -y software-properties-common
  add-apt-repository -y ppa:keithw/mosh
  apt-get update
  echo -ne "\n" | apt-get install -y mosh
fi

