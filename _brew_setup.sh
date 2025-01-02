#!/bin/bash

# Installs homebrew and some essential apps

# Install Homebrew (http://brew.sh)
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Check if Python is installed
if ! command -v python3 &>/dev/null; then
  echo "Python not found. Installing Python 3.11..."
  brew install python@3.11
else
  # Check if the installed Python version is 3.11
  python_version=$(python3 --version 2>&1)
  if [[ $python_version != *"3.11"* ]]; then
    echo "Updating to Python 3.11..."
    brew install python@3.11
  else
    echo "Python 3.11 is already installed."
  fi
fi

# Install Cask (needed for managing GUI apps)
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python3

# Update Homebrew
brew update

# Install brews and casks
brew bundle
