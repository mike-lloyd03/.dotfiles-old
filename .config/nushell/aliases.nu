alias vim = nvim
alias svim = sudo nvim
alias sn = source ~/.config/nushell/config.nu
alias dotfiles = cd ~/.dotfiles
alias dcomp = docker compose
alias jc = sudo journalctl -xe

# if (uname | str trim) == "Linux" {
    alias xcopy = xclip -rmlastnl -in -selection clipboard
    alias xpaste = xclip -out -selection clipboard
# }

# if not (which nvimpager | is-empty) {
    alias less = nvimpager -p
    alias lesss = /usr/bin/less
# }

# git
alias g = git
alias gundo = git reset --soft HEAD~1
alias ga = git add
alias gaa = git add --all
alias gc = git commit -v
alias gcm = git commit -v -m
alias gca = git commit -v --all
alias gcam = git commit -v --all -m
alias gpl = git pull
alias gl = git log
alias gp = git push
alias gr = git remote
alias gra = git remote add
alias grs = git restore
alias grss = git restore --staged
alias gs = git status -s
alias gst = git status
alias gd = git diff --ignore-all-space
alias gds = git diff --staged
alias gsw = git switch
alias gco = git checkout
alias gcob = git checkout -b
alias gb = git branch
alias gsu = git submodule update --recursive --remote
alias gf = git fetch

# systemctl
alias sc = sudo systemctl
alias scr = sudo systemctl restart
alias scstart = sudo systemctl start
alias scstop = sudo systemctl stop
alias sce = sudo systemctl enable
alias scen = sudo systemctl enable --now
alias scstat = sudo systemctl status
alias scdr = sudo systemctl daemon-reload
