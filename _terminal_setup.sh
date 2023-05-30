#!/bin/bash

# Setups up the zsh prompt w/ Powerlevel9k

function install_oh_my_zsh {
  if [ -d ${HOME}/.oh-my-zsh/ ]; then
    echo "Found ~/.oh-my-zsh"
  else
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  fi
}

function install_zsh_autocomplete {
  echo "Installing zsh autocomplete"
  sh -c "$(git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions)"
}

function install_percol {
  sh -c "$(sudo pip install percol)"
}

function switch_to_zsh {
  if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
     # assume Zsh
     echo 'Using zsh already'
  elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
     # assume Bash
     echo 'Switching bash --> zsh'
     chsh -s /bin/zsh
     echo 'Open a new shell tab/window to get zsh'
  else
     # asume something else
     echo 'Not sure what shell this is, switching to zsh anyways'
     chsh -s /bin/zsh
     echo 'Open a new shell tab/window to get zsh'
  fi
}

function install_powerlevel9k {
  if [ -d ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/ ] ; then
    echo "zsh syntax highlighting already installed"
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi

  if [ -d ${HOME}/.oh-my-zsh/custom/themes/powerlevel9k/ ] ; then
    echo "Powerlevel9k theme already installed"
  else
    git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
  fi
  echo "Don't forget to update the font in iTerm to 'Hack Regular Nerd Font Complete'"
}

#### Git-so-fancy colors
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

#####
install_oh_my_zsh
switch_to_zsh
install_powerlevel9k
install_zsh_autocomplete
install_percol
