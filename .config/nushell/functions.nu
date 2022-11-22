module functions {
    def vimrc-options [] {
        ls ~/.config/nvim/lua/ | get name | where ($it | str contains ".lua") | path basename | str replace ".lua" ""
    }

    export def vimrc [file?: string@vimrc-options] {
        let nvim_dir = $"($env.HOME)/.config/nvim"
        let file_path = ([$nvim_dir, "lua", $"($file).lua"] | path join)

        if $file == null {
            cd $nvim_dir
            nvim $"([$nvim_dir, 'init.lua'] | path join)"
            cd -
        } else if ($file_path | path exists) {
            cd $nvim_dir
            nvim $file_path
            cd -
        } else {
            echo $"File '($file).lua' not found"
        }
    }

    def nu-config-options [] {
        ls ~/.config/nushell/ | get name | where ($it | str contains ".nu") | path basename | str replace ".nu" ""
    }

    export def nuconf [file?: string@nu-config-options] {
        let nu_dir = $"($env.HOME)/.config/nushell"
        let file_path = ([$nu_dir, $"($file).nu"] | path join)

        if $file == null {
            cd $nu_dir
            nvim $"([$nu_dir, 'config.nu'] | path join)"
            cd -
        } else if ($file_path | path exists) {
            cd $nu_dir
            nvim $file_path
            cd -
        } else {
            echo $"File '($file).nu' not found"
        }
    }

    export def h [...cmd: string] {
        let primary = $cmd.0
        let remainder = ($cmd | range 1.. | str join " ")
        let full = ($cmd | str join " ")

        if $primary == "cargo" {
            cargo help $remainder | run-external $env.PAGER
        } else if $primary == "go" {
            go help $remainder | run-external $env.PAGER
        # } else if (man -w $full | null; $env.LAST_EXIT_CODE == 0) {
        #     man $full
        } else if (run-external $full "--help" | null; $env.LAST_EXIT_CODE == 0) {
            run-external $full "--help" | run-external $env.PAGER
        } else {
            echo "no man page or --help option available for '$cmd'"
        }
    }
}
