##!/bin/bash

# ZSH Config
export ZSH_DISABLE_COMPFIX=true
HYPHEN_INSENSITIVE="true"
plugins=(vi-mode)
VI_MODE_SET_CURSOR=true
export ZSH="$HOME/.dotfiles/ohmyzsh"
source "$ZSH/oh-my-zsh.sh"
source $HOME/.dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias zshrc='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias svenv='source .venv/bin/activate'
alias dotfiles="cd $HOME/.dotfiles"
command -v docker &>/dev/null && alias dcomp="docker compose"
command -v rg &>/dev/null && alias rgih="rg --no-ignore --hidden"
command -v exa &>/dev/null && alias ls="exa"
command -v journalctl &>/dev/null && alias jc='sudo journalctl -xe'

if command -v nvim &>/dev/null; then
  alias vim='nvim'
  alias svim='sudo nvim'
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# git Aliases
if command -v git &>/dev/null; then
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
  alias grss='git restore --staged'
  alias gs='git status -s'
  alias gst='git status'
  alias gd='git diff --ignore-all-space'
  alias gds='git diff --staged'
  alias gsw='git switch'
  alias gco='git checkout'
  alias gcob='git checkout -b'
  alias gb='git branch'
  alias gsu='git submodule update --recursive --remote'
  alias gf='git fetch'
fi

# systemctl Aliases
if command -v systemctl &>/dev/null; then
  alias sc="sudo systemctl"
  alias scr="sudo systemctl restart"
  alias scstart="sudo systemctl start"
  alias scstop="sudo systemctl stop"
  alias sce="sudo systemctl enable"
  alias scen="sudo systemctl enable --now"
  alias scstat="sudo systemctl status"
  alias scdr="sudo systemctl daemon-reload"
fi

# kubectl Aliases
if command -v kubectl &>/dev/null; then
  alias k="kubectl"
  alias kc="kubectl create"
  alias kcd="kubectl create deployment"
  alias kcj="kubectl create job"
  alias kg="kubectl get"
  alias kgp="kubectl get pods"
  alias kgn="kubectl get nodes"
  alias kgd="kubectl get deployments"
  alias kgj="kubectl get jobs"
  alias kd="kubectl describe"
  alias kdd="kubectl describe deployments"
  alias kdp="kubectl describe pods"
  alias kdn="kubectl describe nodes"
  alias kl="kubectl logs"
  alias ke="kubectl exec"
  alias keit="kubectl exec -it"
  alias kdl="kubectl delete"
fi

function prepend_path() {
  if [[ $PATH != *"$1"* ]]; then
    export PATH="$1:$PATH"
  fi
}

prepend_path "$HOME/.cargo/bin"
prepend_path "$HOME/go/bin"
prepend_path "$HOME/.local/bin"

if [ "$(uname)" = "Linux" ]; then
  alias xcopy="xclip -rmlastnl -in -selection clipboard"
  alias xpaste="xclip -out -selection clipboard"
fi

# Personal Machine Setup
if [ "$(uname -n)" = kratos ] || [ "$(uname -n)" = dev ]; then
  prepend_path "$HOME/.nvm/versions/node/v12.16.1/bin"
  prepend_path "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
  prepend_path "$HOME/.local/share/gem/ruby/2.7.0/bin"

  alias om=optimus-manager
  alias pacman-ls-orphan="sudo pacman -Qdtq"
  alias pacman-rm-deps="sudo pacman -Rcns"
fi

# Work Machine Setup
if [ "$(uname -n)" = TD-C02FK3H8MD6T ]; then
  prepend_path "/usr/local/opt/gnubin:/usr/local/bin"
  export MANPATH=/usr/local/opt/gnuman:${MANPATH:-/usr/share/man}

  # k8s config
  export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-dev"

  alias kdev='kubectl config use-context appsec-dev'
  alias kprod='kubectl config use-context appsec-prod'
  alias pip="pip3"
  alias python="python3"
  alias release='~/go/src/github.td.teradata.com/Application-Security/shared/common/release.sh'
  alias sed="gsed"
fi

# Dev Machine Setup
if [ "$(uname -n)" = dev ]; then
  export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-dev"

  alias kdev='kubectl config use-context appsec-dev'
  alias kprod='kubectl config use-context appsec-prod'
  alias release='~/go/src/github.td.teradata.com/Application-Security/shared/common/release.sh'
  alias psql="psql postgres://postgres:postgres@localhost"
  alias fixdate="sudo date \"$(ssh mac date '+%m%d%H%M%Y.%S')\""
fi

# Launch tmux
if [ ! -v TMUX ] &&
  [ "$DISPLAY" = ":0" ] &&
  [ "$(whoami)" != "root" ]; then
  tmux attach || tmux
  echo -ne "\e[?1004l']" # For dealing with dumb focus issues.
fi

source $HOME/.dotfiles/zsh_functions

# Starship prompt
eval "$(starship init zsh)"
