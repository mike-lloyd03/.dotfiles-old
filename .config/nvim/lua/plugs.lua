require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use({
        "neovim/nvim-lspconfig",
        commit = "607ff48b970b89c3e4e3825b88d9cfd05b7aaea5",
    })
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
    use("tpope/vim-fugitive")
    use("navarasu/onedark.nvim")
    use("preservim/vim-lexical")
    use("dhruvasagar/vim-zoom")
    use("junegunn/goyo.vim")
    use("chrisbra/csv.vim")
    use("mhartington/formatter.nvim")
    use("kylechui/nvim-surround")
    use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
    use("simrat39/rust-tools.nvim")
    use("ron-rs/ron.vim")
    use("karb94/neoscroll.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("ggandor/leap.nvim")
    use("leafOfTree/vim-svelte-plugin")
    use("LhKipp/nvim-nu")
    use({ "JoosepAlviste/nvim-ts-context-commentstring", requires = "terrortylor/nvim-comment" })
    use({ "akinsho/flutter-tools.nvim", requires = { "nvim-lua/plenary.nvim", "dart-lang/dart-vim-plugin" } })
end)

require("theme")

-- gitsigns config
require("gitsigns").setup()

-- Telescope config
require("telescope").load_extension("fzf")
require("telescope").load_extension("flutter")
require("telescope").load_extension("notify")

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
        file_ignore_patterns = {
            "package-lock\\.json",
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
    context_commentstring = {
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
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    layout = {
        height = { min = 1, max = 50 }, -- min and max height of the columns
        width = { min = 5, max = 50 }, -- min and max width of the columns
        spacing = 1, -- spacing between columns
        align = "right", -- align columns left, center or right
    },
    popup_mappings = {
        scroll_down = "<c-j>", -- binding to scroll down inside the popup
        scroll_up = "<c-k>", -- binding to scroll up inside the popup
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
})

-- nvim-autopairs config
require("nvim-autopairs").setup({})

-- nvim-notify config
require("notify").setup({
    max_width = 80,
    top_down = false,
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
    logging = false,
    filetype = {
        css = require("formatter.defaults.prettier"),
        dart = require("formatter.filetypes.dart").dartformat,
        go = require("formatter.filetypes.go").gofmt,
        html = require("formatter.defaults.prettier"),
        javascript = require("formatter.defaults.prettier"),
        json = require("formatter.defaults.prettier"),
        lua = { Stylua },
        markdown = require("formatter.defaults.prettier"),
        python = {
            require("formatter.filetypes.python").black,
            require("formatter.filetypes.python").isort,
        },
        rust = { Rustfmt },
        sh = { Shfmt },
        svelte = require("formatter.defaults.prettier"),
        typescript = require("formatter.defaults.prettier"),
        toml = require("formatter.filetypes.toml").taplo,
        yaml = require("formatter.defaults.prettier"),
        zsh = { Shfmt },
    },
})

-- nvim.surround setup
require("nvim-surround").setup({
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ms",
        normal_cur = "mss",
        normal_line = "mS",
        normal_cur_line = "mSS",
        visual = "ms",
        visual_line = "mS",
        delete = "md",
        change = "mr",
    },
})

-- trouble.nvim setup
require("trouble").setup({})

-- rust-tools setup
local rt = require("rust-tools")

rt.setup({
    tools = {
        inlay_hints = {
            only_current_line = true,
            show_parameter_hints = false,
            -- highlight = "VertSplit",
            -- highlight = "lualine_a_mode_inactive",
            highlight = "DevIconDoc",
        },
    },
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
                inlayHints = { locationLinks = false },
            },
        },
    },
})

-- vsnip setup
vim.g.vsnip_snippet_dir = "~/.config/nvim/vsnip"

-- CMP setup
local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](1) == 1 then
                feedkey("<Plug>(vsnip-jump-next)", "")
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            elseif cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        }),
    },

    -- Installed sources
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "path" },
        { name = "buffer" },
    },
})

-- neoscroll setup
require("neoscroll").setup({
    easing_function = "cubic",
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    cursor_scrolls_alone = false,
})

local t = {}
t["<C-k>"] = { "scroll", { "-5", "false", "250" } }
t["<C-j>"] = { "scroll", { "5", "false", "250" } }
require("neoscroll.config").set_mappings(t)

-- indent-blankline setup
require("indent_blankline").setup({
    space_char_blankline = " ",
    use_treesitter_scope = true,
})

-- leap setup
require("leap").add_default_mappings()
-- require("leap").opts.highlight_unlabeled_phase_one_targets = true
require("leap").opts.special_keys = {
    next_target = { "<tab>" },
    prev_target = { "<S-tab>" },
}
-- get highlight groups with :so $VIMRUNTIME/syntax/hitest.vim
vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "debugBreakpoint" })

-- nvim-nu setup
require("nu").setup({})

-- nvim_comment setup
require("nvim_comment").setup({
    comment_empty = false,
    hook = function()
        if vim.api.nvim_buf_get_option(0, "filetype") == "svelte" then
            ---@diagnostic disable-next-line: missing-parameter
            require("ts_context_commentstring.internal").update_commentstring()
        end
    end,
})

-- flutter-tools
require("flutter-tools").setup({
    ui = {
        notification_style = "native",
    },
})
