#! /bin/sh

# ln -s ~/.dotfiles/{.vim,.vimrc,.tmux,.tmux.conf} ~/
# ln -s ~/.dotfiles/.config/{coc, xkb, fish, omf} ~/.config/

dotfiles=(.vim .vimrc .tmux .tmux.conf .config/coc .config/xkb .config/fish .config/omf)

for f in "${dotfiles[@]}"
do
    if [ -e ~/$f ]; then
        mv ~/$f ~/$f.bak
    fi
    ln -s ~/.dotfiles/$f ~/$f
done
