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
-- Defaul LSP Config
----------------------------
require("lspconfig").bashls.setup({})
require("lspconfig").gopls.setup({})
require("lspconfig").jedi_language_server.setup({})

----------------------------
-- Rust Config
----------------------------
require("lspconfig").rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
                allFeatures = true,
                allTargets = true,
            },
        },
    },
})

----------------------------
-- Lua Config
----------------------------
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
            format = {
                enable = true,
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
        -- "lua",
        "python",
        "sh",
        "zsh",
    },
    init_options = {
        filetypes = {
            python = { "pylint", "mypy" },
            sh = "shellcheck",
        },
        linters = {
            mypy = {
                sourceName = "mypy",
                command = "mypy",
                args = { "--no-color-output",
                    "--no-error-summary",
                    "--show-column-numbers",
                    "--follow-imports=silent",
                    "--ignore-missing-imports",
                    "%file"
                },
                formatPattern = { "^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$",
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4
                    }
                },
                securities = {
                    error = "error"
                }
            },
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
            zsh = "shfmt",
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
    -- Fix rust cmp sorting snippets over functions
    -- sorting = {
    --     priority_weight = 2,
    --     comparators = {
    --         cmp.config.compare.score,
    --     },
    -- },
})

----------------------------
-- Ansible Config
----------------------------
require("lspconfig").ansiblels.setup({
    settings = {
        ansible = {
            ansible = {
                useFullyQualifiedCollectionNames = false,
            },
            ansibleLint = {
                arguments = "-x fqcn-builtins",
            },
        },
    },
})
