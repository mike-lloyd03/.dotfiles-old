source "$HOME/.config/fish/aliases.fish"

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

if [ "$(uname -n)" = TD-C02FK3H8MD6T ]
    fish_add_path "/usr/local/opt/gnubin:/usr/local/bin"
    # set -x MANPATH /usr/local/opt/gnuman:${MANPATH:-/usr/share/man}
    set -x KUBECONFIG "$HOME/.kube/config:$HOME/.kube/config-dev"
end

# Keybinds
bind \co edit_command_buffer

if type --quiet skim_key_bindings
    skim_key_bindings
end

# Path
fish_add_path $HOME/.local/bin

# Prompt
starship init fish | source
