###
### OSX-specific .bash_profile
###
HISTFILESIZE=100000000
HISTSIZE=100000

# color terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

### Pathy things
# Path for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/.pyenv/shims:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH=$PATH:~/.local/bin
export PATH="(pyenv root)/shims:/usr/local/bin:/usr/bin:/bin:/usr/local/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/Cellar:/usr/local:$PATH"
# aws
export PATH="/usr/local/bin/aws:$/usr/local/aws:PATH"
# Local utilities
export PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
# aws
export PATH="/usr/local/bin/aws:$/usr/local/aws:PATH"
# Local utilities
export PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
# the classic MySQL library path fix for OSX  (un-comment if installing mysql)
# export LD_LIBRARY_PATH=/usr/local/mysql-5.5.19-osx10.6-x86_64/lib
export PATH=/usr/local/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:~/.ec2/bin

### Source general (osx or linux) bash setup
[[ -f ~/.bash_includes ]] && source ~/.bash_includes

### Source other bash files with specific/private setups
if [ -f ~/.bash_profile_secrets ] ; then source ~/.bash_profile_secrets; fi

### Aliases
alias bp="atom ~/code/dotfiles/bash_profile"
alias bpi="atom ~/code/dotfiles/bash_includes"
alias sourcebp="source ~/.bash_profile"
alias dot="cd ~/code/dotfiles"

## Profile Aliases

alias h="history"
# confirmation #
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias hs="history | grep"
alias grep='grep --color=auto'

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
alias gco='git checkout'

# gsr = Git Search Replace
function gsr() {
    search_string=$1
    replace_string=$2
    if [ -z $search_string ] || [ -z $replace_string ]
    then
        echo "-- Git Search & Replace (gsr)"
        echo "-- usage: gsr search_string replace_string"
    else
        git grep -l $search_string | xargs sed -i '' "s/$search_string/$replace_string/g"
        echo "Crushed it."
    fi
}

### brew bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi

### aws completion
if [ -f `brew --prefix`/bin/aws_completer ]; then
complete -C aws_completer aws
fi

### git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


### NB: Understand below



# VirtualEnvWrapper
export WORKON_HOME=~/virtualenvs
if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then source /usr/local/bin/virtualenvwrapper.sh; fi

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo rbenv not installed; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; else echo pyenv not installed; fi

# go path
export GOPATH=$HOME/go

# generate ctags in different languages
alias ctags_ruby='ctags -R --languages=ruby --exclude=.git --exclude=vendor/bundle --exclude=node_modules --exclude=coverage'
alias ctags_python='ctags -R --languages=python --exclude=.git --exclude=node_modules --exclude=coverage'

# EC2 Command Line Tools - not really using recently
# export JAVA_HOME="`/usr/libexec/java_home -v 1.6`"
# export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
# export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
# export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"


### OSX-specific aliases
# run local mongodb (from /usr/local) and put it in the background
# alias mongolocal='sudo mongod run --config /usr/local/etc/mongod.conf --fork && sleep 1 && tail -20 /usr/local/var/log/mongodb/mongod.log'

# toggle show/hide hidden files in Finder
alias showhidefileson='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias showhidefilesoff='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'


### NPM Module common scripts
alias karma='./node_modules/karma/bin/karma'
alias karmaone='./node_modules/karma/bin/karma start --singleRun --browsers PhantomJS'

# added by Anaconda2 4.3.1 installer
export PATH="/anaconda/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# AWS 
export AWS_ACCESS_KEY_ID="$(aws configure get default.aws_access_key_id)"
export AWS_SECRET_ACCESS_KEY="$(aws configure get default.aws_secret_access_key)"

# need to change this for different aws accounts
function login_into_ecr {
  aws ecr get-login-password   | docker login -u AWS --password-stdin https://193567999519.dkr.ecr.us-east-1.amazonaws.com
}

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

# show all files with cd
function cd {
    builtin cd "$@" && ls
}
