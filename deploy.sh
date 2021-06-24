#! /bin/sh

<<<<<<< HEAD
dotfiles=(.vim .vimrc .tmux .tmux.conf .config/coc .config/xkbcomp .zshrc .oh-my-zsh .local/share/zsh .config/karabiner)
=======
set -x

dotfiles=(.vim .vimrc .tmux .tmux.conf .config/coc .config/fish .config/omf)
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

# Check if fish is installed.
which fish > /dev/null 2>&1
if [ $? = 0 ]; then
    # Check if oh-my-fish is installed. If not, install it.
    which omf > /dev/null 2>&1
    if [ $? != 0 ]; then
        curl -L https://get.oh-my.fish | fish
    fi
else
    echo "fish must be installed to use this script."
    exit 1
fi
>>>>>>> f2914d101349ad97208caed27b58ab2988cae0cf

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
exit 0
