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
    Plug 'lewis6991/gitsigns.nvim' "Depends on plenary
    Plug 'nvim-telescope/telescope.nvim' "Depends on plenary
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-fugitive'
    Plug 'joshdick/onedark.vim'
    Plug 'preservim/vim-lexical'
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'dhruvasagar/vim-zoom'

    call plug#end()
]])

-- Color scheme config
vim.cmd([[
    augroup colorscheme
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
    colorscheme onedark
    augroup end
]])

-- NERDTree Config
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1
vim.g.NERDTreeIgnore = { '__pycache__', '.session.vim' }

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
