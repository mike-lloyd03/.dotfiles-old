local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            require("theme")
        end,
    },
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim",
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
        },
        config = function()
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
        end,
    },
    {
        "hrsh7th/vim-vsnip",
        config = function()
            vim.g.vsnip_snippet_dir = "~/.config/nvim/vsnip"
        end,
    },
    "golang/vscode-go",
    "rust-lang/vscode-rust",
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        opts = {
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
        },
    },
    "nvim-treesitter/playground",
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
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
        end,
    },
    "nvim-lualine/lualine.nvim",
    "kyazdani42/nvim-web-devicons",
    "kyazdani42/nvim-tree.lua",
    {
        "rmagatti/auto-session",
        opts = function()
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
            return {
                log_level = "info",
                auto_session_suppress_dirs = { "~/", "/tmp/", "/" },
            }
        end,
    },
    {
        "folke/which-key.nvim",
        opts = {
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
        },
    },
    { "windwp/nvim-autopairs", config = true },
    "stevearc/dressing.nvim",
    {
        "rcarriga/nvim-notify",
        opts = function()
            vim.notify = require("notify")
            return {
                max_width = 80,
                top_down = false,
            }
        end,
    },
    "windwp/nvim-ts-autotag",
    "tpope/vim-fugitive",
    "preservim/vim-lexical",
    "dhruvasagar/vim-zoom",
    "junegunn/goyo.vim",
    "chrisbra/csv.vim",

    {
        "mhartington/formatter.nvim",
        lazy = false,
        opts = function()
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

            return {
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
                    sql = { "formatter.filetypes.sql" },
                    svelte = require("formatter.defaults.prettier"),
                    typescript = require("formatter.defaults.prettier"),
                    toml = require("formatter.filetypes.toml").taplo,
                    yaml = require("formatter.defaults.prettier"),
                    zsh = { Shfmt },
                },
            }
        end,
    },

    {
        "kylechui/nvim-surround",
        opts = {
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
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
    },
    {
        "simrat39/rust-tools.nvim",
        ft = {
            "rust",
            "toml",
        },
        opts = {

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
                on_attach = function(client, bufnr)
                    -- Hover actions
                    vim.keymap.set(
                        "n",
                        "<C-space>",
                        require("rust-tools").hover_actions.hover_actions,
                        { buffer = bufnr }
                    )
                    -- Code action groups
                    vim.keymap.set(
                        "n",
                        "<Leader>a",
                        require("rust-tools").code_action_group.code_action_group,
                        { buffer = bufnr }
                    )
                    require("nvim-navic").attach(client, bufnr)
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
        },
    },
    "ron-rs/ron.vim",
    {
        "karb94/neoscroll.nvim",
        opts = function()
            local t = {}
            t["<C-k>"] = { "scroll", { "-5", "false", "250" } }
            t["<C-j>"] = { "scroll", { "5", "false", "250" } }
            require("neoscroll.config").set_mappings(t)

            return {
                easing_function = "cubic",
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
                cursor_scrolls_alone = false,
            }
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            space_char_blankline = " ",
            use_treesitter_scope = true,
        },
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
            require("leap").opts.special_keys = {
                next_target = { "<tab>" },
                prev_target = { "<S-tab>" },
            }
            -- get highlight groups with :so $VIMRUNTIME/syntax/hitest.vim
            vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "debugBreakpoint" })
        end,
    },
    "leafOfTree/vim-svelte-plugin",
    "LhKipp/nvim-nu",
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
            "terrortylor/nvim-comment",
        },
        config = function()
            require("nvim_comment").setup({
                comment_empty = false,
                hook = function()
                    if vim.api.nvim_buf_get_option(0, "filetype") == "svelte" then
                        ---@diagnostic disable-next-line: missing-parameter
                        require("ts_context_commentstring.internal").update_commentstring()
                    end
                end,
            })
        end,
    },
    {
        "akinsho/flutter-tools.nvim",
        ft = "dart",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "dart-lang/dart-vim-plugin",
        },
        opts = {
            ui = {
                notification_style = "native",
            },
            lsp = {
                on_attach = function(client, bufnr)
                    require("nvim-navic").attach(client, bufnr)
                end,
            },
        },
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        -- config = function()
        --     require("nvim-navic").setup({
        --         highlight = true,
        --     })
        --     vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        -- end,
        opts = function()
            vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
            return {
                highlight = true,
            }
        end,
    },
    "tpope/vim-abolish",
    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            window = {
                border = "rounded",
            },
            lsp = {
                auto_attach = true,
            },
        },
    },
})
