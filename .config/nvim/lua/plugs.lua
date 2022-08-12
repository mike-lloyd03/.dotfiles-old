require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use({ "hrsh7th/vim-vsnip", "hrsh7th/cmp-vsnip", "golang/vscode-go", "rust-lang/vscode-rust" })
    use("onsails/lspkind-nvim")
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/playground")
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })
    use("nvim-lualine/lualine.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("kyazdani42/nvim-tree.lua")
    use("rmagatti/auto-session")
    use("folke/which-key.nvim")
    use("windwp/nvim-autopairs")
    use("stevearc/dressing.nvim")
    use("rcarriga/nvim-notify")
    use("windwp/nvim-ts-autotag")
    use("tpope/vim-commentary")
    use("tpope/vim-surround")
    use("tpope/vim-fugitive")
    use("navarasu/onedark.nvim")
    use("preservim/vim-lexical")
    use("dhruvasagar/vim-zoom")
    use("junegunn/goyo.vim")
    use("chrisbra/csv.vim")
    use("mhartington/formatter.nvim")
end)

require("theme")

-- gitsigns config
require("gitsigns").setup()

-- Telescope config
require("telescope").load_extension("fzf")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require("telescope.actions").close,
                ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
                ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
            },
        },
        layout_config = {
            cursor = {
                width = 60,
                height = 10,
            },
            scroll_speed = 1,
        },
    },
    pickers = {
        spell_suggest = {
            layout_strategy = "cursor",
            sorting_strategy = "ascending",
        },
        buffers = {
            sort_lastused = true,
            mappings = {
                i = {
                    ["<C-d>"] = require("telescope.actions").delete_buffer,
                },
            },
        },
    },
})

-- Treesitter config
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 100

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    playground = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
})

-- auto-session Config
function _G.close_all_floating_wins()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= "" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.g.auto_session_pre_save_cmds = {
    _G.close_all_floating_wins,
    "tabdo NvimTreeClose",
}
require("auto-session").setup({
    log_level = "info",
    auto_session_suppress_dirs = { "~/" },
})

-- which-key.nvim config
require("which-key").setup({
    plugins = {
        spelling = {
            enabled = false,
        },
    },
    layout = {
        align = "center",
    },
})

-- nvim-autopairs config
require("nvim-autopairs").setup({})

-- nvim-notify config
require("notify").setup({
    max_width = 80,
    max_height = 5,
})
vim.notify = require("notify")

-- formatter.nvim config
function Shfmt()
    return {
        exe = "shfmt",
        args = {
            "-i",
            "4",
        },
        stdin = true,
    }
end

function Stylua()
    return {
        exe = "stylua",
        args = {
            "--indent-type",
            "spaces",
            "-",
        },
        stdin = true,
    }
end

function Rustfmt()
    return {
        exe = "rustfmt",
        args = {
            "--edition",
            "2021",
        },
        stdin = true,
    }
end

require("formatter").setup({
    filetype = {
        css = require("formatter.defaults.prettier"),
        go = require("formatter.filetypes.go").gofmt,
        html = require("formatter.defaults.prettier"),
        json = require("formatter.defaults.prettier"),
        lua = { Stylua },
        python = {
            require("formatter.filetypes.python").black,
            require("formatter.filetypes.python").isort,
        },
        rust = { Rustfmt },
        sh = { Shfmt },
        toml = require("formatter.filetypes.toml").taplo,
        yaml = require("formatter.defaults.prettier"),
        zsh = { Shfmt },
    },
})
