source "$HOME/.config/fish/aliases.fish"
source "$HOME/.config/fish/functions.fish"

# vim bindings
fish_vi_key_bindings
set fish_vi_force_cursor true
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# Environment
set -U PAGER nvimpager
set -U EDITOR nvim
set -U fish_greeting ""

# Keybinds
bind \co edit_command_buffer
skim_key_bindings

# Path
fish_add_path $HOME/.local/bin

# Prompt
starship init fish | source
