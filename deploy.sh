#! /bin/sh

dotfiles=(.vim .vimrc .tmux .tmux.conf .config/coc .config/xkbcomp .config/fish .config/omf .config/karabiner)

echo "Deploying .dotfiles..."
for f in "${dotfiles[@]}"
do
    if [ -e ~/$f ]; then
        if [ $(readlink ~/$f) = ~/.dotfiles/$f ]; then
            echo "Link for $f already exists. Skipping."
            continue
        fi
        echo "$f already exists. Backing up."
        mv ~/$f ~/$f.pre-deploy
    fi
    echo "Creating link for $f"
    ln -s ~/.dotfiles/$f ~/$f
done
echo "Done."
