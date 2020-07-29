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
## 


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
dockutil --remove 'Keynotes'
dockutil --remove 'Downloads'
dockutil --remove 'System Preferences'
