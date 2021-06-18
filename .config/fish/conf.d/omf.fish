# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

export PATH="$HOME/.poetry/bin:$PATH"
export EDITOR='vim'

alias svim='sudo vim'
alias chkjrn='sudo journalctl -xe'
alias xmap='sh ~/.config/xkbcomp/vim-keys-xkb.sh'
alias startfusuma='killall fusuma && fusuma -d'
alias load-kvm="sudo /home/mike/Documents/scripts/intel_gvt-g_setup/start-kvm-gvt-g.sh"
alias ls="exa"
alias cat="bat"

# Launch tmux
if test ! -n "$TMUX"
  tmux
end
