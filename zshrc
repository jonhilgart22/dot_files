# set language to utf 8 english
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

### Pathy things
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
# Local utilities
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/Cellar:/usr/local:$PATH"
export PATH=$PATH:~/.local/bin:/usr/local/go/bin
# below for mysql
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
# aws
export PATH="/usr/local/bin/aws:$/usr/local/aws:${PATH}"
# Path for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$(pyenv root)/shims:$PATH"
# go path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

### Source general (osx or linux) bash setup
[[ -f ~/bash_includes_zshrc ]] && source ~/bash_includes_zshrc

# color terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Ensure home directory name is correct
export USER=$(whoami)
export ZSH="/Users/$USER/.oh-my-zsh"
plugins=(
  git
  zsh-syntax-highlighting
  poetry
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_affirm dir vcs newline
  # icons_test newline
  context virtualenv status
)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Set colors
# To see all the colors, run: for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
# POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_DIR_FOREGROUND='white'
POWERLEVEL9K_DIR_BACKGROUND='009' # dark-grey
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='007' # light-grey

# POWERLEVEL9K_VCS_BACKGROUND="10" # light/pastel green
POWERLEVEL9K_VCS_FOREGROUND='white'

# Customize the git icons/emojis
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'⚠️ '
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'🙅🏻‍♂️'
POWERLEVEL9K_VCS_STAGED_ICON=$'🚀'

# Context
POWERLEVEL9K_CONTEXT_BACKGROUND="white" # not working

# VirtualEnv
POWERLEVEL9K_VIRTUALENV_BACKGROUND="white"

# Load Nerd Fonts with Powerlevel9k theme for Zsh
POWERLEVEL9K_MODE='nerdfont-complete'

# Source/turn on Powerlevel9k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Misc
HISTFILESIZE=100000
HISTSIZE=10000

### Source other bash files with specific/private setups
if [ -f ~/.affirm_specifics ] ; then source ~/.affirm_specifics; fi
alias modaffirm="atom ~/.affirm_specifics"

### Aliases
alias bp="code ~/code/dotfiles/bash_profile"
alias bpi="code ~/code/dotfiles/bash_includes"
alias sourcebp="source ~/.bash_profile"

alias zshconfig="code ~/code/dotfiles/zshrc"
alias sourcezsh="source ~/.zshrc"

alias dot="cd ~/code/dotfiles"
alias kc=kubectl

## Profile Aliases

alias h="history"
# confirmation #
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias hs="history | grep"
alias cd="cd"
alias findn="find . -print | grep -i"
### Show all files in a directory
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ ls -la; }


### Docker aliases
alias dk='docker-compose'
alias dlogs='docker-compose logs -f --tail=50'
alias cslogs='docker-sync logs -f'

### Git
alias lsl='ls -G -lh --color=auto'
function lsp() { ls -lh $1 | egrep -v '.*.pyc$'; }
alias grep='grep -i --color=auto'
alias gg='git grep -n --color --heading --break'
alias .b='source ~/.bashrc && source ~/.bash_profile'
alias gd='git diff'
alias gac='git add . && git commit -a -m '

# gsr = Git Search Replace is in bash_includes_zshrc


### git completion
fpath=(~/.zsh $fpath)

autoload -U compinit && compinit
zmodload -i zsh/complist



### aws 
# source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh
function ecr_login() {
  ecr_url="$(aws ecr get-authorization-token --output text --query 'authorizationData[].proxyEndpoint' | awk -Fhttps:// '{print $2}')"
  login_status="$(aws ecr get-login-password | docker login -u AWS --password-stdin https://"${ecr_url}")"
  echo "${login_status}"
}


### TODO: Understand the below better

# VirtualEnvWrapper
# export WORKON_HOME=~/virtualenvs
if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then source /usr/local/bin/virtualenvwrapper.sh; fi

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo rbenv not installed; fi

# generate ctags in different languages
# alias ctags_ruby='ctags -R --languages=ruby --exclude=.git --exclude=vendor/bundle --exclude=node_modules --exclude=coverage'
# alias ctags_python='ctags -R --languages=python --exclude=.git --exclude=node_modules --exclude=coverage'

### OSX-specific aliases
# run local mongodb (from /usr/local) and put it in the background
# alias mongolocal='sudo mongod run --config /usr/local/etc/mongod.conf --fork && sleep 1 && tail -20 /usr/local/var/log/mongodb/mongod.log'

# toggle show/hide hidden files in Finder
alias showhidefileson='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias showhidefilesoff='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'

### NPM Module common scripts
# alias karma='./node_modules/karma/bin/karma'
# alias karmaone='./node_modules/karma/bin/karma start --singleRun --browsers PhantomJS'

## NVM package maanger
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"


# Change your ssh tabs
function tabc {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  osascript -e "tell application "Terminal" to set current settings of front window to settings set "$NAME""
}

function ssh {
  tabc "SSH-theme"
  /usr/bin/ssh "$@"
  tabc "Visor"
}

## AWS
# AWS 
export AWS_ACCESS_KEY_ID="$(aws configure get default.aws_access_key_id)"
export AWS_SECRET_ACCESS_KEY="$(aws configure get default.aws_secret_access_key)"

# need to change this for different aws accounts
function login_into_ecr {
  aws ecr get-login-password   | docker login -u AWS --password-stdin https://193567999519.dkr.ecr.us-east-1.amazonaws.com
}

#Nodenv
eval "$(nodenv init -)"

# Final pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; else echo pyenv not installed; fi
# init rbenv
eval "$(rbenv init -)"

# Poetry init
# Modify path for Python's poetry dependency management system
export PATH="$HOME/.poetry/bin:$PATH"
alias poetry_shell='. "$(dirname $(poetry run which python))/activate"'

# VScode on path
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# neeva
export KUBECONFIG=$(git rev-parse --show-toplevel)/production/instances/dev-us-west-2/eks/kubeconfig
export NAMESPACE=jonathan
export NEEVA_USER=jonathan
alias kc='kubectl --namespace ${NAMESPACE} '
alias awsprod='pushd ~/code/neeva; eval $(go run neeva.co/cmd/prodaccess aws shell --eval); eval $(./setup_dev.sh setup); popd'
export PATH=/opt/homebrew/bin:$PATH
eval $(/opt/homebrew/bin/brew shellenv)

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/go@1.18/bin:$PATH"

## history completeion
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

# snowflake
alias python=/opt/homebrew/bin/python3
alias pip=/opt/homebrew/bin/pip3
export VANITY_USER=jhilgart
source ~/.awscredentials
