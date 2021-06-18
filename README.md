# .dotfiles

A portable collection of my settings for vim, fish, tmux, xkb and other stuff.

To use, git clone recursively into your home folder and symlink the desired
directories to your home folder.

```bash
$ git clone --recurse-submodules git@github.com:mike-lloyd03/.dotfiles.git
$ ln -s ~/.dotfiles/{.vim,.vimrc,.tmux,.tmux.conf} ~/
$ ln -s ~/.dotfiles/.config/{coc, xkb, fish, omf} ~/.config/
```

