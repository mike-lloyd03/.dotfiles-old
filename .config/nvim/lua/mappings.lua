local function nmap(shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap("n", shortcut, command, opts)
end

local function imap(shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap("i", shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap("v", shortcut, command, opts)
end

-- Control j and h to scroll
nmap("<C-j>", "<C-e>")
nmap("<C-k>", "<C-y>")
imap("<C-j>", "<C-e>")
imap("<C-k>", "<C-y>")
vmap("<C-j>", "<C-e>")
vmap("<C-k>", "<C-y>")

-- Helix inspiration
nmap("gh", "0")
nmap("gl", "$")
vmap("gh", "0")
vmap("gl", "$")
nmap("<space>w", "<C-w>")
nmap("U", "<C-r>")
vmap(">", ">gv")
vmap("<", "<gv")
vmap("<space>y", '"+y')
nmap("<space>p", '"+p')
nmap("<space>P", '"+P')

-- Telescope
nmap("<space>b", "<CMD>lua require('telescope.builtin').buffers{}<CR>")
nmap("<space>f", "<CMD>Telescope find_files<CR>")
nmap("<space>g", "<CMD>Telescope live_grep<CR>")
nmap("<space>h", "<CMD>Telescope help_tags<CR>")
nmap("<space>'", "<CMD>Telescope resume<CR>")
nmap("<space>s", "<CMD>lua require('telescope.builtin').lsp_document_symbols{}<CR>")
nmap("<space>S", "<CMD>lua require('telescope.builtin').lsp_workspace_symbols{}<CR>")
nmap("<space>a", "<CMD>lua vim.lsp.buf.code_action()<CR>")
nmap("gr", "<CMD>lua require('telescope.builtin').lsp_references{}<CR>")
nmap("<space>z", "<CMD>lua require('telescope.builtin').spell_suggest{}<CR>")
nmap("gd", "<CMD>lua require('telescope.builtin').lsp_definitions{}<CR>")
nmap("gD", "<CMD>lua require('telescope.builtin').lsp_definitions{jump_type='vsplit'}<CR>")
nmap("<leader>sv", "<CMD>source ~/.config/nvim/init.lua<CR>")

function search_dotfiles()
    require("telescope.builtin").find_files({
        prompt_title = "< vimrc >",
        cwd = "~/.config/nvim",
        hidden = true,
    })
end

nmap("<leader>vr", "<CMD>lua search_dotfiles()<CR>")

-- Find and replace under cursor
nmap("<leader>s", ":%s/<C-r><C-w>/")

-- Clear hightlight after search
nmap("<C-_>", "<CMD>nohlsearch<CR>")

-- LSP/Diagnostics
nmap("[g", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
nmap("]g", "<CMD>lua vim.diagnostic.goto_next()<CR>")
nmap("<space>k", "<CMD>lua vim.lsp.buf.hover()<CR>")
nmap("gi", "<CMD>lua vim.lsp.buf.implementation()<CR>")
nmap("<space>wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>")
nmap("<space>wr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>")
nmap("<space>wp", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
nmap("<space>D", "<CMD>lua vim.lsp.buf.type_definition()<CR>")
nmap("<space>r", "<CMD>lua vim.lsp.buf.rename()<CR>")


-- Go Imports
function FormatAndOrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

nmap("gi", "<CMD>lua FormatAndOrgImports(1000)<CR>")

-- NvimTree
nmap("<C-n>", "<CMD>NvimTreeToggle<CR>")

-- gitsigns
nmap("]c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", { expr = true })
nmap("[c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", { expr = true })

-- Register which-key names
local wk = require("which-key")
wk.register({
    ["<space>"] = {
        b = { "Buffers" },
        f = { "Find files" },
        g = { "Live grep" },
        h = { "Search help tags" },
        s = { "Document symbols" },
        S = { "Workspace symbols" },
        a = { "Code actions" },
        r = { "Rename" },
        D = { "Type definition" },
        k = { "Show docs for item under cursor" },
        w = { "Window" },
        wa = { "Add workspace folder" },
        wp = { "Print workspace folders" },
        wr = { "Remove workspace folders" },
        ["'"] = { "Open last picker" },
        y = { "Yank selection to system clipboard" },
        p = { "Paste system clipboard after cursor" },
        P = { "Paste system clipboard before cursor" },
        z = { "Show spelling suggestions" },
    },
    g = {
        c = { "Toggle comment" },
        d = { "Go to definition" },
        D = { "Go to definition in new vsplit" },
        r = { "Go to references" },
        h = { "Line start" },
        l = { "Line end" },
    },
    ["["] = {
        c = { "Previous hunk" },
        g = { "Previous diagnostic" },
    },
    ["]"] = {
        c = { "Next hunk" },
        g = { "Next diagnostic" },
    },
    ["<leader>"] = {
        s = { "Find and replace under cursor" },
        sv = { "Source vimrc" },
        vr = { "Search dotfiles" },
        ts = { "onedark theme toggle" },
    },
})
