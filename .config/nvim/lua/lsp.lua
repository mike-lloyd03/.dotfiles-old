vim.opt.completeopt = "menuone,noselect,noinsert"
vim.opt.shortmess = vim.opt.shortmess + "c" -- Avoid showing extra messages when using completion

vim.diagnostic.config({
    virtual_text = false, -- Disable virtual text
    severity_sort = true,
})

local python_venv = "$HOME/.config/nvim/venv-nvim"

vim.g.python3_host_prog = python_venv .. "/bin/python"

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

----------------------------
-- Rust Config
-- See https://github.com/simrat39/rust-tools.nvim#configuration
----------------------------

-- local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = false,
        hover_with_actions = true,
        inlay_hints = {
            -- only_current_line = true,
            show_parameter_hints = false,
            -- parameter_hints_prefix = "",
            -- other_hints_prefix = "",
        },
    },

    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        settings = {
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                    allFeatures = true,
                    allTargets = true,
                },
            },
        },
    },
}

require("rust-tools").setup(opts)

----------------------------
-- Defaul LSP Config
----------------------------
require("lspconfig").bashls.setup({})
require("lspconfig").gopls.setup({})
require("lspconfig").jedi_language_server.setup({
    -- cmd = {python_venv .. "/bin/jedi-language-server"},
})

require("lspconfig").sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
--
----------------------------
-- Diagnostic Language Server Config
----------------------------

require("lspconfig").diagnosticls.setup({
    filetypes = {
        "c",
        "cpp",
        "css",
        "html",
        "json",
        "lua",
        "python",
        "sh",
    },
    init_options = {
        filetypes = {
            python = "pylint",
            sh = "shellcheck",
        },
        linters = {
            pylint = {
                sourceName = "pylint",
                command = "pylint",
                args = {
                    "--output-format",
                    "text",
                    "--score",
                    "no",
                    "--msg-template",
                    "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'",
                    "%file",
                },
                formatPattern = {
                    "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4,
                    },
                },
                rootPatterns = { ".git", "pyproject.toml", "setup.py" },
                securities = {
                    informational = "hint",
                    refactor = "info",
                    convention = "info",
                    warning = "warning",
                    error = "error",
                    fatal = "error",
                },
                offsetColumn = 1,
                formatLines = 1,
            },
            shellcheck = {
                command = "shellcheck",
                debounce = 100,
                args = {
                    "--format",
                    "json",
                    "-",
                },
                sourceName = "shellcheck",
                parseJson = {
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "${message} [${code}]",
                    security = "level",
                },
                securities = {
                    error = "error",
                    warning = "warning",
                    info = "info",
                    style = "hint",
                },
            },
        },
        formatFiletypes = {
            c = "clang_format",
            cpp = "clang_format",
            css = "prettier",
            html = "prettier",
            json = "prettier",
            lua = "stylua",
            python = {
                "black",
                "isort",
            },
            sh = "shfmt",
            yaml = "prettier",
        },
        formatters = {
            black = {
                command = "black",
                args = { "--quiet", "--fast", "-" },
            },
            clang_format = {
                command = "clang-format",
                args = { "--style=LLVM" },
            },
            isort = {
                command = "isort",
                args = { "--quiet", "-" },
            },
            stylua = {
                command = "stylua",
                args = { "--indent-type", "spaces", "-" },
            },
            prettier = {
                command = "prettier",
                args = { "--stdin-filepath", "%filepath" },
            },
            shfmt = {
                command = "shfmt",
                args = { "-i", "2" },
            },
        },
    },
})
require("lspconfig").sqls.setup({})

----------------------------
-- CMP Config
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
----------------------------
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
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        }),
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
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
