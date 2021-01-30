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
install bat 
install the_silver_searcher 
install cointop 
install fastlane 
install htop 
install iftop 
install postgresql 
install mosh 
install autoconf 
install wxmac 
install openssl
install fop 
install coreutils
install libyaml 
install libtool 
install libxslt 
install unixodbc 
install unzip 
install readline
install httpie

# GUI Apps
brew tap homebrew/drivers
brew tap adoptopenjdk/openjdk
brew install --cask \
  visual-studio-code \
  google-chrome \
  iterm2 \
  docker \
  alfred \
  spotify \
  rectangle \
  authy \
  sourcetree \
  1password \
  monodraw \
  adoptopenjdk8 \
  logitech-options \
  telegram \
  endel \
  fantastical
  line \
  outline \
  notion


# Gaming xD
brew install --cask \
  minecraft \
  steam

# XCode
print_header "Installing XCode"
mas install 497799835

print_header "Installing Be Focused Pro"
mas install 961632517

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

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false  

## Config Trackpad

# Trackpad: enable tap to click for this user and for the login screen
print_header "Set one-tap to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

## Config Keyboard

# Set a blazingly fast keyboard repeat rate
print_header "Set keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1.5
defaults write NSGlobalDomain InitialKeyRepeat -int 13

## Config Animation
print_header "Setup Animation"
# opening and closing windows and popovers
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# showing and hiding sheets, resizing preference windows, zooming windows
# float 0 doesn't work
defaults write -g NSWindowResizeTime -float 0.001

# opening and closing Quick Look windows
defaults write -g QLPanelAnimationDuration -float 0

# showing a toolbar or menu bar in full screen
defaults write -g NSToolbarFullScreenAnimationDuration -float 0

echo "done"

# Config Computer Name (Required password)
# scutil --set ComputerName "omg.network"
# scutil --set LocalHostName "omgnetwork"

## Setup Font
print_header "Setup Font"
brew tap homebrew/cask-fonts && brew cask install font-iosevka && brew cask install font-iosevka-slab

echo "done"

## Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  print_header "done"
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  print_header "Cloning zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  curl -L -o ~/.zshrc https://raw.githubusercontent.com/ripzery/setup/master/.zshrc
  echo "done"
fi

## Setup NVM, Yarn, NPM
if [ ! -d "$HOME/.nvm" ]; then
  print_header "Installing NVM and Yarn..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh)"
  source ~/.zshrc
  nvm install --lts

  # Install Yarn
  curl -o- -L https://yarnpkg.com/install.sh | bash
  echo "done"
fi

## Setup VIM
if [ ! -f "$HOME/.vimrc" ]; then
  print_header "Setup VIM..."
  curl -L -o ~/.vimrc https://raw.githubusercontent.com/ripzery/vimrc/master/.vimrc
  print_header "Installing VIM plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall > /dev/null 
  echo "done"
fi

## Setup ITerm2 Integration
print_header "Setup ITerm2"
curl -L https://iterm2.com/shell_integration/zsh \
  -o ~/.iterm2_shell_integration.zsh

## Setup Elixir and Erlang
print_header "Installing ASDF and Elixir"
install asdf
if ! command -v erl; then
  export CFLAGS="-O2 -g -fno-stack-check"
  export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf install erlang 22.3.1
fi

if ! command -v elixir; then
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  asdf install elixir 1.10.2
fi

asdf global erlang 22.3.1
asdf global elixir 1.10.2

# Elixir OMG
print_header "Setup Elixir-OMG"
sh -C "$(curl -fsSL https://raw.githubusercontent.com/omgnetwork/elixir-omg/master/bin/setup)" > /dev/null
