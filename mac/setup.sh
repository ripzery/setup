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

## 
