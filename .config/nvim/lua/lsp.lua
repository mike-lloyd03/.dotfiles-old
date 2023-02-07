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

local navic = require("nvim-navic")

----------------------------
-- Defaul LSP Config
----------------------------
require("lspconfig").bashls.setup({})
require("lspconfig").gopls.setup({})
require("lspconfig").pyright.setup({
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
})
require("lspconfig").svelte.setup({})
require("lspconfig").tsserver.setup({})
require("lspconfig").eslint.setup({})

----------------------------
-- Lua Config
----------------------------
require("lspconfig").sumneko_lua.setup({
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
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
