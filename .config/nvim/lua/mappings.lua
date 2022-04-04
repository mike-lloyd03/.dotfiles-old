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

-- Helix inspiration
nmap("gh", "0")
nmap("gl", "$")
vmap("gh", "0")
vmap("gl", "$")
nmap("<space>w", "<C-w>")
nmap("U", "<C-r>")

-- Telescope
nmap("<space>b", "<CMD>lua require('telescope.builtin').buffers{sort_lastused=true}<CR>")
nmap("<space>f", "<CMD>Telescope find_files<CR>")
nmap("<space>g", "<CMD>Telescope live_grep<CR>")
nmap("<space>h", "<CMD>Telescope help_tags<CR>")
nmap("<space>'", "<CMD>Telescope resume<CR>")
nmap("<space>s", "<CMD>lua require('telescope.builtin').lsp_document_symbols{}<CR>")
nmap("<space>S", "<CMD>lua require('telescope.builtin').lsp_workspace_symbols{}<CR>")
nmap("<space>a", "<CMD>lua require('telescope.builtin').lsp_code_actions{}<CR>")
nmap("gr", "<CMD>lua require('telescope.builtin').lsp_references{}<CR>")
nmap("z=", "<CMD>lua require('telescope.builtin').spell_suggest{}<CR>")
nmap("gd", "<CMD>lua require('telescope.builtin').lsp_definitions{}<CR>")
nmap("gD", "<CMD>lua require('telescope.builtin').lsp_definitions{jump_type='vsplit'}<CR>")
-- nmap("gt", "<CMD>lua require('telescope.builtin').treesitter{}<CR>")
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
