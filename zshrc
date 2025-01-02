# Pathy things
export PATH="$HOME/.rbenv/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/Cellar:/usr/local:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

function exists { which $1 &> /dev/null }


# Set language to utf-8 English
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Oh My Zsh settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  zsh-syntax-highlighting
  poetry
  zsh-autosuggestions
  macos
)

source $ZSH/oh-my-zsh.sh

# Customise the Powerlevel10k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_affirm dir vcs newline
  context virtualenv status
)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Set colors
POWERLEVEL9K_DIR_FOREGROUND='white'
POWERLEVEL9K_DIR_BACKGROUND='009' # dark-grey
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='007' # light-grey
POWERLEVEL9K_VCS_FOREGROUND='white'

# Customize the git icons/emojis
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'⚠️ '
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'🙅🏻‍♂️'
POWERLEVEL9K_VCS_STAGED_ICON=$'🚀'

# Context
POWERLEVEL9K_CONTEXT_BACKGROUND="white"

# VirtualEnv
POWERLEVEL9K_VIRTUALENV_BACKGROUND="white"

# Load Nerd Fonts with Powerlevel10k theme for Zsh
POWERLEVEL9K_MODE='nerdfont-complete'

# Misc
HISTFILESIZE=100000
HISTSIZE=10000

# Aliases
alias bp="code ~/code/dotfiles/bash_profile"
alias bpi="code ~/code/dotfiles/bash_includes"
alias sourcebp="source ~/.bash_profile"

alias zshconfig="code ~/.zshrc"
alias sourcezsh="source ~/.zshrc"

alias dot="cd ~/code/dotfiles"
alias kc="kubectl"

## Profile Aliases
alias h="history"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias hs="history | grep"
alias cd="cd"

## Show all files in a directory
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ ls -la; }

## Docker aliases
alias dk='docker-compose'
alias dlogs='docker-compose logs -f --tail=50'
alias cslogs='docker-sync logs -f'

## Git
alias lsl='ls -G -lh --color=auto'
function lsp() { ls -lh $1 | egrep -v '.*.pyc$'; }
alias grep='grep -i --color=auto'
alias gg='git grep -n --color --heading --break'
alias .b='source ~/.bashrc && source ~/.bash_profile'
alias gd='git diff'
alias gac='git add . && git commit -a -m '

### Git completion
fpath=(~/.zsh $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist

### AWS
function ecr_login() {
  ecr_url="$(aws ecr get-authorization-token --output text --query 'authorizationData[].proxyEndpoint' | awk -Fhttps:// '{print $2}')"
  login_status="$(aws ecr get-login-password | docker login -u AWS --password-stdin https://${ecr_url})"
  echo "${login_status}"
}

## VirtualEnvWrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

## rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
else
  echo "rbenv not installed"
fi

## Poetry init
export PATH="$HOME/.poetry/bin:$PATH"
alias poetry_shell='. "$(dirname $(poetry run which python))/activate"'

## VScode on path
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

## Nodenv
eval "$(nodenv init -)"

## Final pyenv
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
else
  echo "pyenv not installed"
fi

## Completion and history settings
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

## Powerlevel10k theme sourcing
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

## AWS Profile
export AWS_PROFILE="pacific-prod"

# Modify the exists function to be more reliable
exists() {
    command -v "$1" >/dev/null 2>&1
}

# Move percol configuration before the final sourcing commands
if exists percol; then
    function percol_select_history() {
        local tac
        if exists gtac; then
            tac="gtac"
        elif exists tac; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle -R -c
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(/opt/homebrew/bin/brew shellenv)"
