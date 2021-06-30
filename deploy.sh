#! /bin/sh

# set -x

dotfiles=(.vim .vimrc .tmux .tmux.conf .config/coc .zshrc .oh-my-zsh .local/share/zsh .config/starship.toml)
linux_dotfiles=(.config/xkbcomp)
mac_dotfiles=(.config/karabiner)

if [ $(uname -s) = Linux ]; then
    dotfiles+=( ${linux_dotfiles[@]} )
elif [ $(uname -s) = Darwin ]; then
    dotfiles+=( ${mac_dotfiles[@]} )
else
    echo "Cannot deploy on this system."
    exit 1
fi

echo "Deploying .dotfiles..."
for f in "${dotfiles[@]}"
do
    if [ -e $HOME/$f ]; then
        if [ -L $HOME/$f -a $(readlink $HOME/$f) = $HOME/.dotfiles/$f ]; then
            echo "Link for $f already exists. Skipping."
            continue
        fi
        echo "$f already exists. Backing up."
        mv $HOME/$f $HOME/$f.pre-deploy
    fi
    echo "Creating link for $f"
    ln -s $HOME/.dotfiles/$f $HOME/$f
done
echo "Done."
exit 0
