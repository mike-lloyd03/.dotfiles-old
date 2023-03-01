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

function fishconf
    set config_dir "$HOME/.config/fish"
    set edit_file "$argv[1]"

    if [ -z $edit_file ]
        pushd $config_dir >/dev/null && nvim "$HOME/.config/fish/config.fish" && popd >/dev/null
        return 0
    end

    if find "$config_dir/" -name "*.fish" | grep -P "$config_dir/$edit_file.fish" >/dev/null
        pushd $config_dir >/dev/null && nvim "$config_dir/$edit_file.fish" && popd >/dev/null
    else
        echo "$edit_file.fish not found in fish config directory"
    end
end

complete -c fishconf -a "$(ls ~/.config/fish/ | grep -P '.*\.fish$' | string replace '.fish' '')" -f

function zm
    set session_name "main-$(hostname)"
    if zellij ls | grep $session_name &> /dev/null
        zellij attach $session_name
    else
        zellij -s $session_name
    end
end

function zs
    set session_name "scratch-$(hostname)"
    if zellij ls | grep $session_name &> /dev/null
        zellij attach $session_name
    else
        zellij -s $session_name
    end
end


function cdm
    mkdir -p $argv[1]
    cd $argv[1]
end

function h
    set cmd $argv
    if [ "$argv[1]" = "cargo" ]
        cargo help "$cmd[2..]" | $PAGER
    else if [ "$argv[1]" = "go" ]
        go help "$cmd[2..]" | $PAGER
    else if [ "$argv[1]" = "aws" ]
        "$cmd" help | $PAGER
    else if [ "$argv[1]" = "cargo" ]
        cargo help "$cmd[2..]"
    else if man -w "$cmd" &>/dev/null
        man "$cmd"
    else if eval "$cmd --help" &>/dev/null
        eval "$cmd --help" | $PAGER
    else
        echo "no man page or --help option available for '$cmd'"
        return 1
    end
end

complete -c h -xa "(__fish_complete_command)"

function unzipd
    set ZIP_FILE "$argv[1]"
    set FILE_NAME "$(basename --suffix .zip $ZIP_FILE)"

    if [ "$argv[2][-1]" = "/" ]
        set OUT_DIR "$argv[2]/$FILE_NAME"
    else
        set OUT_DIR "$argv[2]"
    end

    if [ ! -d "$OUT_DIR" ]
        mkdir "$OUT_DIR"
    end

    echo $OUT_DIR $ZIP_FILE

    unzip -d "$OUT_DIR" "$ZIP_FILE"
end
