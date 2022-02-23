-- https://www.notonlycode.org/neovim-lua-config/
require('plugs')
require('lsp')
require('mappings')
require('statusline')

-- Command mode zsh-like autocompletion
vim.opt.signcolumn = 'yes'
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode="longest:full,full"
vim.opt.wildignore="*.o,*~"

-- Split panes open on the right or below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Break lines at word boundaries when wrapping and wrap to previous indent
vim.opt.linebreak = true
vim.opt.breakindent = true

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- autoindent and tab options
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- put a line under the cursor
vim.opt.cursorline = true

-- Smart case when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-----------
-- Auto Commands
-----------
-- Markdown bindings
vim.cmd([[
  autocmd Filetype markdown noremap <buffer> <silent> k gk
  autocmd Filetype markdown noremap <buffer> <silent> j gj
  autocmd Filetype markdown noremap <buffer> <silent> 0 g0
  autocmd Filetype markdown noremap <buffer> <silent> $ g$
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd FileType markdown call lexical#init()
]])

-- Format on Save
vim.cmd([[
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
]])
