# .dotfiles

A portable collection of my settings for vim, zsh, tmux, xkb and other stuff.

To use, git clone recursively (preferably into your home directory) and run the `deploy.sh` script. This will automatically configure your system to use these dotfiles.
```bash
$ git clone --recurse-submodules git@github.com:mike-lloyd03/.dotfiles.git
$ ./.dotfiles/deploy.sh
```

Dependencies:
- `vim`
- `tmux`
- `zsh`
- `oh-my-zsh` (will be auto-installed)
- `nodejs`
- `starship`
- `gopls`
- `black`
- `shfmt`
- `shellcheck`
