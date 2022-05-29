require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    respect_buf_cwd = false,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    filters = {
        dotfiles = false,
        custom = { ".git", '__pycache__', '.venv', '.pytest_cache' },
        exclude = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 200,
    },
    view = {
        width = 35,
        height = 35,
        hide_root_folder = false,
        side = "left",
        mappings = {
            custom_only = false,
            list = {
                { key = "s", action = "vsplit" },
                { key = "i", action = "split" },
                { key = "t", action = "tabnew" },
                { key = "?", action = "toggle_help" },
                { key = "c", action = "cd" },
            },
        },
        number = false,
        relativenumber = false,
        signcolumn = "no",
    },
    renderer = {
        group_empty = true,
        highlight_opened_files = "name",
        icons = {
            padding = " ",
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "!",
                    staged = "+",
                    unmerged = "",
                    renamed = "»",
                    untracked = "?",
                    deleted = "✘",
                    ignored = "",
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            }
        },
    }
})
