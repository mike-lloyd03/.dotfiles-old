vim.cmd([[
    call plug#begin('~/.local/share/nvim/plugs')

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'onsails/lspkind-nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground' "Depends on nvim-treesitter
    Plug 'lewis6991/gitsigns.nvim' "Depends on plenary
    Plug 'nvim-telescope/telescope.nvim' "Depends on plenary and apparently tree-sitter
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'rmagatti/auto-session'
    Plug 'folke/which-key.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'stevearc/dressing.nvim'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'navarasu/onedark.nvim'
    Plug 'preservim/vim-lexical'
    Plug 'dhruvasagar/vim-zoom'


    call plug#end()
]])

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
            },
        },
        layout_config = {
            cursor = {
                width = 60,
                height = 10,
            },
        },
    },
    pickers = {
        spell_suggest = {
            layout_strategy = "cursor",
            sorting_strategy = "ascending",
        },
        lsp_code_actions = {
            layout_strategy = "cursor",
            sorting_strategy = "ascending",
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
})

-- auto-session Config
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.g.auto_session_pre_save_cmds = { "tabdo NvimTreeClose" }
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
