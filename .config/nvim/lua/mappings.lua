local function nmap(shortcut, command, opts)
    opts = opts or {noremap = true}
    vim.api.nvim_set_keymap('n', shortcut, command, opts)
end
-- Control j and h to scroll
nmap("<C-j>", "<C-e>")
nmap("<C-k>", "<C-y>")

-- Telescope
nmap("<C-b>", "<cmd>Telescope buffers<cr>")
nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")

function search_dotfiles()
	require("telescope.builtin").find_files({
		prompt_title = "< vimrc >",
		cwd = "~/.config/nvim",
		hidden = true,
    })
end
nmap("<leader>vimrc", ":lua search_dotfiles()<CR>")

-- Find and replace under cursor
nmap("<Leader>s", "<cmd>%s/<<C-r><C-w>>/")

-- Clear hightlight after search
nmap("<C-_>", "<cmd>nohlsearch<CR>")

-- LSP/Diagnostics
nmap("[g", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
nmap("]g", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- nmap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nmap("<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
nmap("<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
nmap("<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
nmap("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
nmap("<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
nmap("<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")

-- NERDTree
nmap("<C-n>", "<cmd>NERDTreeToggle<cr>")

-- Vista
nmap("<C-l>", ":Vista finder<CR>")

-- gitsigns
nmap("]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr = true})
nmap("[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr = true})