#!/bin/sh

print_header()
{
  echo ""
  echo "####### $1 #######"
  echo ""
}

install()
{
  apt-get install -y $1 
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

# Install curl

if ! command -v curl > /dev/null; then
  print_header "Installing curl..."
  install curl
fi

if ! command -v gpg  > /dev/null; then
  print_header "Installing gpg..."
  install gnupg2
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
  install software-properties-common
  add-apt-repository -y ppa:keithw/mosh
  echo -ne "\n" | install mosh
fi


# Install zsh

installed_zsh=1
if ! command -v zsh > /dev/null; then
  print_header "Installing zsh..."
  install zsh
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  print_header "Cloning zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  curl -L -o ~/.zshrc https://raw.githubusercontent.com/ripzery/setup/master/.zshrc
  installed_zsh=0
fi

# Install fd

if ! command -v fdfind > /dev/null; then
  print_header "Installing fd..."
  install fd-find
fi

# Install fzf

if ! command -v fzf > /dev/null; then
  print_header "Installing fzf..."
  install fzf
fi

# Install ripgrep

if ! command -v rg > /dev/null; then
  print_header "Installing ripgrep..."
  install ripgrep
fi

# Install ag

if ! command -v ag > /dev/null; then
  print_header "Installing Ag..."
  install silversearcher-ag
fi

# Install Httpie

if ! command -v http > /dev/null; then
  print_header "Installing HTTPie..."
  install httpie
fi

# Install nvm

if ! command -v nvm > /dev/null; then
  print_header "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  . ~/.bashrc
  nvm install --lts
fi

if ! command -v yarn > /dev/null; then
  print_header "Installing yarn..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
  apt-get update 
  apt-get install -y --no-install-recommends yarn
fi

if ! command -v npm > /dev/null; then
  print_header "Installing npm..."
  apt-get install -y --no-install-recommends npm
fi

# Install VIM

if ! command -v vim > /dev/null; then
  print_header "Installing VIM..."
  install vim
  curl -L -o ~/.vimrc https://raw.githubusercontent.com/ripzery/vimrc/master/.vimrc
  print_header "Installing VIM plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall > /dev/null
fi

echo "# SUMMARY"

print_header "Git"
git --version
print_header "Curl"
curl --version
print_header "Gpg"
gpg --version
print_header "Mosh"
mosh --version
print_header "Zsh"
zsh --version
print_header "Fd"
fdfind --version
print_header "Fzf"
fzf --version
print_header "Ripgrep"
rg --version
print_header "Ag"
ag --version
print_header "nvm"
nvm --version
print_header "yarn"
yarn --version
print_header "nvm"
nvm --version
print_header "node"
node --version

echo "Finish."

if [ "$installed_zsh" = "0" ]; then
  chsh -s $(which zsh)
  echo "Use zsh!"
  zsh
fi
