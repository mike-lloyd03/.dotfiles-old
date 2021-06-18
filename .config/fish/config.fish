export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"
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
