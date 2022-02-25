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
    "Plug 'nvim-lua/popup.nvim'
    Plug 'onsails/lspkind-nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim' "Depends on plenary
    Plug 'nvim-telescope/telescope.nvim' "Depends on plenary
    Plug 'RishabhRD/popfix'
    Plug 'hood/popui.nvim' "Depends on popfix
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
    Plug 'liuchengxu/vista.vim'
    Plug 'junegunn/fzf' "Required for vista finder

    call plug#end()
]])

-- Color scheme config
vim.cmd([[
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
    colorscheme onedark
]])

-- NERDTree Config
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1
vim.g.NERDTreeIgnore = { '__pycache__', '.session.vim' }

-- Vista Config
vim.g.vista_default_executive = 'nvim_lsp'
vim.g['vista#renderer#enable_icon'] = 1
vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}

-- gitsigns config
require('gitsigns').setup()

-- PopUI config
if not vim.fn.has("mac") then
    vim.ui.select = require"popui.ui-overrider"
    -- vim.ui.input = require"popui.ui-input-override"
end
