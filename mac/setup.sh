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
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
