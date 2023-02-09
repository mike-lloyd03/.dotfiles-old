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

local function navic_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

----------------------------
-- Defaul LSP Config
----------------------------
require("lspconfig").bashls.setup({
    on_attach = navic_attach,
})
require("lspconfig").gopls.setup({
    on_attach = navic_attach,
})
require("lspconfig").pyright.setup({
    on_attach = navic_attach,
})
require("lspconfig").svelte.setup({
    on_attach = navic_attach,
})
require("lspconfig").tsserver.setup({
    on_attach = navic_attach,
})
require("lspconfig").eslint.setup({})

----------------------------
-- Lua Config
----------------------------
require("lspconfig").sumneko_lua.setup({
    on_attach = navic_attach,
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
