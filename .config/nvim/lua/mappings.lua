local function nmap(shortcut, command, opts)
    opts = opts or {noremap = true}
    vim.api.nvim_set_keymap('n', shortcut, command, opts)
end

-- Control j and h to scroll
nmap("<C-j>", "<C-e>")
nmap("<C-k>", "<C-y>")


-- Telescope
nmap("<C-b>", "<CMD>lua require('telescope.builtin').buffers{sort_lastused=true}<CR>")
nmap("<leader>ff", "<CMD>Telescope find_files<CR>")
nmap("<leader>fg", "<CMD>Telescope live_grep<CR>")
nmap("<leader>fh", "<CMD>Telescope help_tags<CR>")
nmap("<C-l>", "<CMD>lua require('telescope.builtin').lsp_document_symbols{}<CR>")
nmap("gr", "<CMD>lua require('telescope.builtin').lsp_references{}<CR>")
nmap("z=", "<CMD>lua require('telescope.builtin').spell_suggest{}<CR>")
nmap("<leader>ca", "<CMD>lua require('telescope.builtin').lsp_code_actions{}<CR>")
nmap("gd", "<CMD>lua require('telescope.builtin').lsp_definitions{}<CR>")
nmap("gD", "<CMD>lua require('telescope.builtin').lsp_definitions{jump_type='vsplit'}<CR>")

function search_dotfiles()
	require("telescope.builtin").find_files({
		prompt_title = "< vimrc >",
		cwd = "~/.config/nvim",
		hidden = true,
    })
end
nmap("<Leader>vr", "<CMD>lua search_dotfiles()<CR>")
nmap("<Leader>sv", "<CMD>source ~/.config/nvim/init.lua<CR>")

-- Find and replace under cursor
nmap("<Leader>s", ":%s/<C-r><C-w>/")

-- Clear hightlight after search
nmap("<C-_>", "<CMD>nohlsearch<CR>")

-- LSP/Diagnostics
nmap("[g", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
nmap("]g", "<CMD>lua vim.diagnostic.goto_next()<CR>")
nmap("K", "<CMD>lua vim.lsp.buf.hover()<CR>")
nmap("gi", "<CMD>lua vim.lsp.buf.implementation()<CR>")
nmap("<space>wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>")
nmap("<space>wr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>")
nmap("<space>wl", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
nmap("<space>D", "<CMD>lua vim.lsp.buf.type_definition()<CR>")
nmap("<leader>r", "<CMD>lua vim.lsp.buf.rename()<CR>")
nmap("<space>f", "<CMD>lua vim.lsp.buf.formatting()<CR>")

-- NERDTree
nmap("<C-n>", "<CMD>NvimTreeToggle<CR>")

-- Minimap
nmap("<C-p>", "<CMD>MinimapToggle<CR>")

-- gitsigns
nmap("]c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", {expr = true})
nmap("[c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", {expr = true})
