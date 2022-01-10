#!/bin/bash

# set -x

# BD=$(tput bold)
NM=$(tput sgr0)
# UL=$(tput smul)
GN=$(tput setaf 2)
YL=$(tput setaf 3)
RD=$(tput setaf 1)

prefix="${GN}[.dotfiles deploy]${NM}"
prefix_warn="${YL}[.dotfiles deploy]${NM}"
prefix_err="${RD}[.dotfiles deploy]${NM}"

script_location="$(cd "$(dirname "$0")" && pwd -P)"

dotfiles=(.vim .vimrc .tmux .tmux.conf .config/coc .zshrc .oh-my-zsh .local/share/zsh .config/starship.toml .gitignore-global)
linux_dotfiles=(.config/xkbcomp)
mac_dotfiles=(.config/karabiner)

if [ "$(uname -s)" = Linux ]; then
    dotfiles+=("${linux_dotfiles[@]}")
elif [ "$(uname -s)" = Darwin ]; then
    dotfiles+=("${mac_dotfiles[@]}")
else
    echo "$prefix_err Cannot deploy on this system."
    exit 1
fi

echo "$prefix Deploying .dotfiles..."
for f in "${dotfiles[@]}"; do
    if [ -e "$HOME/$f" ]; then
        if [ -L "$HOME/$f" ] && [ "$(readlink "$HOME/$f")" = "$script_location/$f" ]; then
            echo "$prefix_warn Link for $f already exists. Skipping."
            continue
        fi
        echo "$prefix_warn $f already exists. Backing up."
        mv "$HOME/$f" "$HOME/$f.pre-deploy"
    fi
    echo "$prefix Creating link for $f"
    mkdir -p "$(dirname "$HOME/$f")"
    ln -s "$script_location/$f" "$HOME/$f"
done

# Install vim-plugs
# vim -c "PlugInstall | qa"

# Setup global .gitignore file
if [ -z "$(git config --global core.excludesfile)" ]; then
    echo "$prefix Setting global .gitignore variable"
    git config --global core.excludesfile "$HOME/.gitignore-global"
else
    echo "$prefix Global .gitignore variable already set."
fi

echo "$prefix Done."
exit 0
