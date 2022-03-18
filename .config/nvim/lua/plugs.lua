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

-- Color scheme config
require('onedark').setup {
    style = 'dark',
      colors = {
        green = '#88D988',
        blue = '#00B6FF',
        cyan = '#56B6C2',
        orange = '#DC8A61',
        red = '#FF618A',
		purple = "#DB61DB",
		yellow = "#D7AF87",
		bg0 = "#1a1c23", -- main bg
		bg1 = "#303030", -- active row bg
		bg2 = "#393f4a", -- nothing
		bg3 = "#3b3f4c", -- dividers and light gray status line bg
		bg_d = "#21252b", -- dark background
		bg_blue = "#00afff",
      },
  highlights = {
    Function = {fg = '$blue'},
    Keyword = {fg = '$red'},
    Include = {fg = '$blue'},
    NormalFloat = {fg = '$fg', bg = '$bg2'},
    FloatBorder = {fg = '$grey', bg = '$bg0'},
    MatchParen = {fg = '$red', bg = '$none', fmt = 'underline'},
    Pmenu = {fg = '$fg', bg = '$bg2'},
    PmenuSel = {fg = '$bg0', bg = '$bg_blue'},
    Search = {fg = '$bg0', bg = '$light_grey'},
    Operator = {fg = '$purple'},

    TSKeyword = {fg = '$red'},
    TSInclude = {fg = '$red'},
    TSFuncMacro = {fg = '$red'},
    TSOperator = {fg = '$purple'},
    TSParameter = {fg = '$light_grey'},
    TSNamespace = {fg = '$blue'},

    TelescopeBorder = {fg = '$light_grey'},
    TelescopePromptBorder = {fg = '$light_grey'},
    TelescopeResultsBorder = {fg = '$light_grey'},
    TelescopePreviewBorder = {fg = '$light_grey'},
    TelescopeMatching = { fg = '$orange', fmt = "bold" },
    TelescopePromptPrefix = {fg = '$red'},

    DiagnosticError = {fg = '$red'},
    DiagnosticHint = {fg = '$purple'},
    DiagnosticInfo = {fg = '$blue'},
    DiagnosticWarn = {fg = '$yellow'},
  }
}
require('onedark').load()
vim.opt.termguicolors = true

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
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}

-- Minimap Config
vim.g.minimap_width = 30
