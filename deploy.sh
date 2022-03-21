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

dotfiles=(.tmux .tmux.conf .zshrc .config/starship.toml .gitignore-global)
linux_dotfiles=(.config/xkbcomp)
mac_dotfiles=(.config/karabiner)
vim_dotfiles=(.vim .vimrc .config/coc)
nvim_dotfiles=(.config/nvim)

if [ "$(uname -s)" = Linux ]; then
  dotfiles+=("${linux_dotfiles[@]}")
elif [ "$(uname -s)" = Darwin ]; then
  dotfiles+=("${mac_dotfiles[@]}")
else
  println "Cannot deploy on this system" error
  exit 1
fi

if command -v nvim &>/dev/null; then
  println "neovim detected"
  vim_cmd=nvim
  dotfiles+=("${nvim_dotfiles[@]}")
else
  vim_cmd=vim
  dotfiles+=("${vim_dotfiles[@]}")
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

# Install vim-plugs
println "Installing $vim_cmd plugs"
vim_plug_path="$HOME/.local/share/nvim/site/autoload/plug.vim"
if [ ! -e $vim_plug_path ]; then
  println "vim-plug not intalled. Installing" warn
  if [ "$vim_cmd" = "nvim" ]; then
    sh -c "curl -fLo '$HOME/.local/share/nvim/site/autoload/plug.vim' --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
fi
$vim_cmd -c "PlugInstall | qa"

println "Done."
exit 0
