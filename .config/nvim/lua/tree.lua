vim.g.nvim_tree_icon_padding = " "
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_icons = {
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
vim.g.nvim_tree_respect_buf_cwd = 0

require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    update_to_buf_dir = {
        enable = false,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = { ".git" },
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
        auto_resize = true,
        mappings = {
            custom_only = false,
            list = {
                { key = "s", action = "vsplit" },
                { key = "i", action = "split" },
                { key = "t", action = "tabnew" },
                { key = "?", action = "toggle_help" },
            },
        },
        number = false,
        relativenumber = false,
        signcolumn = "no",
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    disable_window_picker = true,
})
