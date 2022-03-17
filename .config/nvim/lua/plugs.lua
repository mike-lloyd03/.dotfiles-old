vim.cmd([[
    call plug#begin('~/.local/share/nvim/plugs')

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'onsails/lspkind-nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'lewis6991/gitsigns.nvim' "Depends on plenary
    Plug 'nvim-telescope/telescope.nvim' "Depends on plenary and apparently tree-sitter
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'wfxr/minimap.vim'
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-fugitive'
    Plug 'navarasu/onedark.nvim'
    Plug 'preservim/vim-lexical'
    Plug 'dhruvasagar/vim-zoom'

    call plug#end()
]])

-- Color scheme config
require('onedark').setup {
    style = 'cool'
}
require('onedark').load()
vim.opt.termguicolors = false

-- gitsigns config
require('gitsigns').setup()

-- Telescope config
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close,
            },
        },
        layout_config = {
            cursor = {
                width = 60,
                height = 10,
            }
        }
    },
    pickers = {
        spell_suggest = {
            layout_strategy = 'cursor',
            sorting_strategy = 'ascending'
        },
        lsp_code_actions = {
            layout_strategy = 'cursor',
            sorting_strategy = 'ascending'
        },
    },
}
require('telescope').load_extension('fzf')

-- Minimap Config
vim.g.minimap_width = 30
