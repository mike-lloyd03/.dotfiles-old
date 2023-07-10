#!/bin/bash

# set -x

function println() {
    msg="$1"
    level="${2:-info}"

    # BD=$(tput bold)
    NM=$(tput sgr0)
    # UL=$(tput smul)
    GN=$(tput setaf 2)
    YL=$(tput setaf 3)
    RD=$(tput setaf 1)
    prefix="[.dotfiles deploy]"

    case $level in
    info)
        echo "${GN}${prefix}${NM} $msg"
        ;;
    warn)
        echo "${YL}${prefix}${NM} $msg"
        ;;
    error | err)
        echo "${RD}${prefix}${NM} $msg"
        ;;
    esac
}

script_location="$(cd "$(dirname "$0")" && pwd -P)"

dotfiles=(.config/nushell .config/nvim .config/starship.toml .config/zellij .gitignore-global)
linux_dotfiles=()
mac_dotfiles=(.config/karabiner)

if [ "$(uname -s)" = Linux ]; then
    dotfiles+=("${linux_dotfiles[@]}")
elif [ "$(uname -s)" = Darwin ]; then
    dotfiles+=("${mac_dotfiles[@]}")
else
    println "Cannot deploy on this system" error
    exit 1
fi

println "Deploying .dotfiles..."
if [ ! -e "$HOME/.dotfiles" ]; then
    if [ ! "$(readlink "$HOME/.dotfiles")" = "$script_location" ]; then
        ln -s "$script_location" "$HOME/.dotfiles"
    fi
fi
script_location="$HOME/.dotfiles"

for f in "${dotfiles[@]}"; do
    if [ -e "$HOME/$f" ]; then
        if [ "$(readlink "$HOME/$f")" = "$script_location/$f" ]; then
            println "Link for $f already exists. Skipping." warn
            continue
        fi
        println "$f already exists. Backing up." warn
        mv "$HOME/$f" "$HOME/$f.pre-deploy"
    fi
    println "Creating link for $f"
    mkdir -p "$(dirname "$HOME/$f")"
    ln -s "$script_location/$f" "$HOME/$f"
done

println "Done."
exit 0
