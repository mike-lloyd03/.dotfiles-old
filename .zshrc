# Locale issues fix
export LC_ALL=en_US.utf-8 
export LANG="$LC_ALL" 

# If you come from bash you might have to change your $PATH.
export PATH="/opt/anaconda3/condabin:$PATH"
export PATH="$HOME/.nvm/versions/node/v12.16.1/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/2.7.0/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME='avit-custom'

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='vim'
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias gocode='cd ~/Documents/coding'
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias svenv='source venv/bin/activate'
alias svim='sudo vim'
alias chkjrn='sudo journalctl -xe'
alias xmap='sh ~/.config/xkbcomp/vim-keys-xkb.sh'
alias startfusuma='killall fusuma && fusuma -d'
alias load-kvm="sudo /home/mike/Documents/scripts/intel_gvt-g_setup/start-kvm-gvt-g.sh"
alias ls="exa"
alias cat="bat"

# dotfiles setup
alias dotfiles-fetch='git -C ~/.dotfiles fetch'
alias dotfiles-pull='git -C ~/.dotfiles pull'
alias dotfiles-status='git -C ~/.dotfiles status'
alias dotfiles-commit='git -C ~/.dotfiles add ~/.dotfiles && git -C ~/.dotfiles commit -m "General update" && git -C ~/.dotfiles push'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mike/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# zsh syntax highlighting
source ~/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Launch tmux
if [ ! -v TMUX ]; then
  tmux
fi

export PATH="$HOME/.poetry/bin:$PATH"
