#!/bin/bash

# Installs homebrew and some essential apps

# Install Homebrew (http://brew.sh)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install Cask
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python

# Update Homebrew
brew update

# Install brews and casks
brew bundle
