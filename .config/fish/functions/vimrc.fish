function vimrc
    set nvim_dir "$HOME/.config/nvim/lua"
    set edit_file "$argv[1]"

    if [ "$edit_file" = "" ]
        pushd $HOME/.config/nvim >/dev/null && nvim "$HOME/.config/nvim/init.lua" && popd >/dev/null
        return 0
    end

    if find "$nvim_dir/" -name "*.lua" | grep -P "$nvim_dir/$edit_file.lua" >/dev/null
        pushd $HOME/.config/nvim >/dev/null && nvim "$nvim_dir/$edit_file.lua" && popd >/dev/null
    else
        echo "$edit_file.lua not found in nvim config directory"
    end
end

complete -c vimrc -a "$(ls ~/.config/nvim/lua/ | string replace '.lua' '')" -f
