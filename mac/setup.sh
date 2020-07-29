#!/bin/sh


print_header()
{
  echo ""
  echo "####### $1 #######"
  echo ""
}

install()
{
  if ! brew ls --versions $1 > /dev/null; then
    brew install $1
  fi
}

## Install homebrew
if ! command -v brew > /dev/null; then
  echo -xe "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

## Install homebrew packages
print_header "Install homebrew packages"

install dockutil
install mas
install jq
install tree
install fd
install fzf
install the_silver_searcher
brew cask install \
  visual-studio-code \
  google-chrome \
  iterm2 \
  docker \
  alfred \
  slack \
  spotify \
  rectangle \
  authy \
  sourcetree \
  1password \
  monodraw


# Config Mac OS

## Remove application from dock
print_header "Removing applications from dock..."
dockutil --remove 'Mail'
dockutil --remove 'Music'
dockutil --remove 'FaceTime'
dockutil --remove 'Contacts'
dockutil --remove 'Calendar'
dockutil --remove 'Maps'
dockutil --remove 'TV'
dockutil --remove 'News'
dockutil --remove 'Numbers'
dockutil --remove 'Pages'
dockutil --remove 'Keynote'
dockutil --remove 'Downloads'
dockutil --remove 'System Preferences'
dockutil --remove 'Messages'
dockutil --remove 'Photos'

## Config Dock
defaults write com.apple.dock autohide -bool true && \
killall Dock

## Config Trackpad

# Trackpad: enable tap to click for this user and for the login screen
print_header "Set one-tap to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate
print_header "Set keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

## Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  print_header "Cloning zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  curl -L -o ~/.zshrc https://raw.githubusercontent.com/ripzery/setup/master/.zshrc
fi

## Setup NVM, Yarn, NPM
if ! command -v nvm > /dev/null; then
  print_header "Installing NVM and Yarn..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  . ~/.zshrc
  nvm install --lts

  # Install Yarn
  curl -o- -L https://yarnpkg.com/install.sh | bash
fi

## Setup VIM
if [ ! -f "$HOME/.vimrc" ]; then
  curl -L -o ~/.vimrc https://raw.githubusercontent.com/ripzery/vimrc/master/.vimrc
  print_header "Installing VIM plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall > /dev/null 
fi
