export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"
export EDITOR='vim'

alias svim='sudo vim'
alias chkjrn='sudo journalctl -xe'
alias ls="exa"
alias cat="bat"


# Launch tmux
if test \( ! -n "$TMUX" \) -a \( ! -n "SSH_CLIENT" \)
  tmux
end

# Personal Machine Setup
if test (uname -n) = kratos
  alias xmap='sh ~/.config/xkbcomp/vim-keys-xkb.sh'
  alias startfusuma='killall fusuma && fusuma -d'
  alias load-kvm="sudo /home/mike/Documents/scripts/intel_gvt-g_setup/start-kvm-gvt-g.sh"
end

# Work Machine Setup
if test (uname -n) = TD-C02FK3H8MD6T 
  export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-dev"
  alias kdev='kubectl config use-context appsec-dev'
  alias kprod='kubectl config use-context app-sec'
end
