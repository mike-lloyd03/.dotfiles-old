require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use 'onsails/lspkind-nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'rmagatti/auto-session'
    use 'folke/which-key.nvim'
    use 'windwp/nvim-autopairs'
    use 'stevearc/dressing.nvim'
    use 'rcarriga/nvim-notify'
    use 'windwp/nvim-ts-autotag'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'navarasu/onedark.nvim'
    use 'preservim/vim-lexical'
    use 'dhruvasagar/vim-zoom'
    use 'junegunn/goyo.vim'
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
        if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
        end
    end
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.g.auto_session_pre_save_cmds = {
    _G.close_all_floating_wins,
    "tabdo NvimTreeClose"
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
vim.notify = require("notify")
