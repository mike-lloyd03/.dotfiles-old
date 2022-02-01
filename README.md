# .dotfiles

A portable collection of my settings for vim, zsh, tmux, xkb and other stuff.

To use, git clone recursively (preferably into your home directory) and run the `deploy.sh` script. This will automatically configure your system to use these dotfiles.
```bash
$ git clone --recurse-submodules git@github.com:mike-lloyd03/.dotfiles.git
$ ./.dotfiles/deploy.sh
```

To install vim plugins:
```bash
$ vim -c "PlugInstall"
```

## Required Dependencies
- `vim`
- `tmux`
- `zsh`
- `oh-my-zsh` (will be auto-installed)
- `nodejs`
- `starship`

## Optional Dependencies
- Rust:
    - `rust-analyzer`
- Go:
    - `gopls`
- Python:
    - `black`
    - `isort`
    - `pylint`
- Bash:
    - `bash-language-server`
    - `shfmt`
    - `shellcheck`
- C/C++:
    - `ccls`
    - `clang-format`
- yaml, json, JS, css, html
    - `prettier`
- Terraform:
    - `terraform-ls`
- Vim:
    - `vint`
