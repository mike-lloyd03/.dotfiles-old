local function nmap(shortcut, command)
    vim.api.nvim_set_keymap('n', shortcut, command, {noremap = true})
end
-- Control j and h to scroll
nmap("<C-j>", "<C-e>")
nmap("<C-k>", "<C-y>")

-- fzf Buffers
nmap("<C-b>", "<cmd>Buffers<cr>")

-- Find and replace under cursor
nmap("<Leader>s", "<cmd>%s/<<C-r><C-w>>/")

-- Clear hightlight after search
-- nnoremap <C-_> <Cmd>nohlsearch<CR>
nmap("C-_>", "<Cmd>nohlsearch<CR>")

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

nmap("<C-n>", "<cmd>NERDTreeToggle<cr>")
nmap("<C-l>", ":Vista finder<CR>")
