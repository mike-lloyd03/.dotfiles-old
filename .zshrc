# Aliases
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias svenv='source .venv/bin/activate'
alias svim='sudo vim'
alias chkjrn='sudo journalctl -xe'
alias dcomp="docker compose"
alias gitundo="git reset --soft HEAD~1"

export ZSH_DISABLE_COMPFIX=true
export EDITOR='vim'

export PATH="$PATH:$HOME/go/bin:$HOME/.local/bin"

# Personal Machine Setup
if [ "$(uname -n)" = kratos ]; then
    export PATH="/opt/anaconda3/condabin:$PATH"
    export PATH="$HOME/.nvm/versions/node/v12.16.1/bin:$PATH"
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
    export PATH="$HOME/.local/share/gem/ruby/2.7.0/bin:$PATH"
    export PATH="$HOME/.poetry/bin:$PATH"

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
    export PATH="/usr/local/bin:$PATH"
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
    export PATH="/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin:$PATH"
    export PATH="$PATH:$HOME/.cargo/bin"

    # k8s config
    export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-dev"

    alias kdev='kubectl config use-context appsec-dev'
    alias kprod='kubectl config use-context appsec-prod'
    alias pip="pip3"
    alias python="python3"
    alias release='~/go/src/github.td.teradata.com/Application-Security/shared/common/release.sh'
    alias ls="exa"
    alias grep="ggrep"
    alias sed="gsed"
fi

# ZSH Config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
export DISABLE_LS_COLORS="true"
plugins=(git vi-mode)
source "$ZSH/oh-my-zsh.sh"
# MODE_INDICATOR=""
source $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Launch tmux
if [ ! -v TMUX ] && \
    [ -v DISPLAY ] && \
    [ "$(whoami)" != "root" ]; then
    tmux attach || tmux
    echo -ne "\e[?1004l']" # For dealing with dumb focus issues.
fi

# vim session management
function vim() {
    if [ $# -gt 0 ]; then
        env vim "$@" #-c "Obsession .session.vim"
    elif [ -f ".session.vim" ]; then
        env vim -S .session.vim
    else
        env vim -c "Obsession .session.vim"
    fi
}

function dx() {
    service_name="$1"
    project_name="$(basename $(pwd))"
    args="${@:2}"

    if [ ! -f "docker-compose.yml" ]; then
        echo "not in a docker-compose project directory"
        return 1
    fi
    if [ "$service_name" = "" ]; then
        echo "must include a service name"
        return 1
    fi
    if [ "$args" = "" ]; then
        echo "must include a command to run"
        return 1
    fi

    docker exec -it ${project_name}-${service_name}-1 $args
}

function cdtemp() {
    tmp_dir="$(mktemp -d)"
    cd $tmp_dir
}

# Starship prompt
eval "$(starship init zsh)"
