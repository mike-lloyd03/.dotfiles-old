# Aliases
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias svenv='source venv/bin/activate'
alias svim='sudo vim'
alias chkjrn='sudo journalctl -xe'
alias ls="exa"
alias cat="bat"

export ZSH_DISABLE_COMPFIX=true
export EDITOR='vim'

export PATH="$PATH:$HOME/go/bin:$HOME/.local/bin"

# Personal Machine Setup
if [ $(uname -n) = kratos ]; then
  export PATH="/opt/anaconda3/condabin:$PATH"
  export PATH="$HOME/.nvm/versions/node/v12.16.1/bin:$PATH"
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  export PATH="$HOME/.local/share/gem/ruby/2.7.0/bin:$PATH"
  export PATH="$HOME/.poetry/bin:$PATH"

  alias xmap='sh ~/.config/xkbcomp/vim-keys-xkb.sh'
  alias startfusuma='killall fusuma && fusuma -d'
  alias load-kvm="sudo /home/mike/Documents/scripts/intel_gvt-g_setup/start-kvm-gvt-g.sh"
  alias om=optimus-manager
fi

# Work Machine Setup
if [ $(uname -n) = TD-C02FK3H8MD6T ]; then
  export PATH="/usr/local/bin:$PATH"
  # k8s config
  export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-dev"

  alias kdev='kubectl config use-context appsec-dev'
  alias kprod='kubectl config use-context app-sec'
  alias pip="pip3"
  alias python="python3"
fi

# ZSH Config
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME='avit-custom'
ZSH_THEME=''
HYPHEN_INSENSITIVE="true"
# COMPLETION_WAITING_DOTS="true"
export DISABLE_LS_COLORS="true"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh
MODE_INDICATOR=""
source ~/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('home/mike/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mike/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mike/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mike/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Launch tmux
if [ ! -v TMUX -a ! -v SSH_CONNECTION ]; then
  tmux
  echo -ne "\e[?1004l']" # For dealing with dumb focus issues.
fi

# Starship prompt
eval "$(starship init zsh)"

# Source iterm2 shell integrations
test -e "${HOME}/.iterm2/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2/.iterm2_shell_integration.zsh"
