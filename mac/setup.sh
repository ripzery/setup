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
echo -xe "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## Install homebrew packages

## 
