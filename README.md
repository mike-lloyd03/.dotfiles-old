# .dotfiles

A portable collection of my settings for vim, fish, tmux, xkb and other stuff.

To use, git clone recursively into your home folder and run the `deploy.sh` script. This will automatically configure your system to use these dotfiles.
```bash
$ git clone --recurse-submodules git@github.com:mike-lloyd03/.dotfiles.git
$ sh .dotfiles/deploy.sh
```

Dependencies:
- `vim`
- `tmux`
- `fish`
- `oh-my-fish` (will be auto-installed)
- `nodejs`
