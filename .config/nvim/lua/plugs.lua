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
    " Plug 'joshdick/onedark.vim'
    Plug 'preservim/vim-lexical'
    Plug 'dhruvasagar/vim-zoom'

    call plug#end()
]])

-- vim.cmd('colorscheme onedark')
-- vim.g.termguicolors = false

-- Color scheme config
require('onedark').setup {
    style = 'dark',
      colors = {
        green = '#88D988',
        blue = '#00B6FF',
        orange = '#DC8A61',
        red = '#FF618A',
		purple = "#DB61DB",
		yellow = "#D7AF87",

        black = "#181a1f",
		bg0 = "#282c34",
		bg1 = "#31353f",
		bg2 = "#393f4a",
		bg3 = "#3b3f4c",
		bg_d = "#21252b",
		bg_blue = "#73b8f1",
		bg_yellow = "#ebd09c",
		fg = "#abb2bf",
		-- purple = "#c678dd",
		-- green = "#98c379",
		-- orange = "#d19a66",
		-- blue = "#61afef",
		-- yellow = "#e5c07b",
		cyan = "#56b6c2",
		-- red = "#e86671",
		grey = "#5c6370",
		light_grey = "#848b98",
		dark_cyan = "#2b6f77",
		dark_red = "#993939",
		dark_yellow = "#93691d",
		dark_purple = "#8a3fa0",
		diff_add = "#31392b",
		diff_delete = "#382b2c",
		diff_change = "#1c3448",
		diff_text = "#2c5372",

      },
  highlights = {
    -- TSKeyword = {fg = '$green'},
    -- TSString = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    Function = {fg = '$blue'},
  }
}
require('onedark').load()
-- vim.opt.termguicolors = false

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

-- Treesitter config
-- require'nvim-treesitter.configs'.setup {}

-- Minimap Config
vim.g.minimap_width = 30
