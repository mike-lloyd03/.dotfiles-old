##!/bin/bash
# Aliases
alias zshrc='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias svenv='source .venv/bin/activate'
alias vim='nvim'
alias svim='sudo nvim'
alias jc='sudo journalctl -xe'
alias dcomp="docker compose"
alias dotfiles="pushd $HOME/.dotfiles"

# git Aliases
alias g="git"
alias gundo="git reset --soft HEAD~1"
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -v -m'
alias gca='git commit -v --all'
alias gcam='git commit -v --all -m'
alias gpl='git pull'
alias gl='git log'
alias gp='git push'
alias gr='git remote'
alias gra='git remote add'
alias grs='git restore'
alias gs='git status -s'
alias gst='git status'
alias gd='git diff --ignore-all-space'
alias gds='git diff --staged'
alias gsw='git switch'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch'
alias gsm='git submodule'

# systemctl Aliases
alias sc="sudo systemctl"
alias scr="sudo systemctl restart"
alias scstart="sudo systemctl start"
alias scstop="sudo systemctl stop"
alias sce="sudo systemctl enable"
alias scen="sudo systemctl enable --now"
alias scstat="sudo systemctl status"
alias scdr="sudo systemctl daemon-reload"


export EDITOR='nvim'
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$HOME/.local/bin:$PATH"

# Personal Machine Setup
if [ "$(uname -n)" = kratos ] || [ "$(uname -n)" = dev ]; then
  export PATH="$HOME/.nvm/versions/node/v12.16.1/bin:$PATH"
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  export PATH="$HOME/.local/share/gem/ruby/2.7.0/bin:$PATH"


  alias xmap='sh ~/.config/xkbcomp/vim-keys-xkb.sh'
  alias om=optimus-manager
  alias pacman-ls-orphan="sudo pacman -Qdtq"
  alias pacman-rm-deps="sudo pacman -Rcns"
  alias xcopy="xclip -r -i -selection clipboard"
  alias xpaste="xclip -o -selection clipboard"
  alias ls="exa"
  alias plasma="kstart5 plasmashell"
fi

# Work Machine Setup
if [ "$(uname -n)" = TD-C02FK3H8MD6T ]; then
  export PATH="$PATH:$HOME/.cargo/bin"
  export PATH=/usr/local/opt/gnubin:/usr/local/bin:$PATH
  export MANPATH=/usr/local/opt/gnuman:${MANPATH:-/usr/share/man}

  # k8s config
  export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-dev"

  alias kdev='kubectl config use-context appsec-dev'
  alias kprod='kubectl config use-context appsec-prod'
  alias pip="pip3"
  alias python="python3"
  alias release='~/go/src/github.td.teradata.com/Application-Security/shared/common/release.sh'
  alias ls="exa"
  alias sed="gsed"
  alias docker=podman
  alias docker-compose=podman-compose
  alias dcomp=podman-compose
fi

# Dev Machine Setup
if [ "$(uname -n)" = dev ]; then
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$PATH:$HOME/.cargo/bin"
  export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-dev"

  alias kdev='kubectl config use-context appsec-dev'
  alias kprod='kubectl config use-context appsec-prod'
  alias release='~/go/src/github.td.teradata.com/Application-Security/shared/common/release.sh'
  alias ls="exa"
fi

# ZSH Config
export ZSH_DISABLE_COMPFIX=true
HYPHEN_INSENSITIVE="true"
plugins=(vi-mode)
VI_MODE_SET_CURSOR=true
export ZSH="$HOME/.dotfiles/ohmyzsh"
source "$ZSH/oh-my-zsh.sh"
source $HOME/.dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $HOME/.dotfiles/zsh_functions

# Launch tmux
if [ ! -v TMUX ] &&
  [ -v DISPLAY ] &&
  [ "$(whoami)" != "root" ]; then
  tmux attach || tmux
  echo -ne "\e[?1004l']" # For dealing with dumb focus issues.
fi

# Starship prompt
eval "$(starship init zsh)"
