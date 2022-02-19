"------------------------------------------------------------------------------------
"------ Plug List ------
"------------------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugs')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" From vim
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'preservim/vim-lexical'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'dhruvasagar/vim-zoom'

call plug#end()

"------------------------------------------------------------------------------------
"------ Basic Config ------
"------------------------------------------------------------------------------------
colorscheme onedark

"------ Command mode zsh-like autocompletion -------
set wildmode=longest:full,full
set wildmenu
set wildignore=*.o,*~
set wildignorecase

" Split panes open on the right or below
set splitright
set splitbelow

" Split panes use solid lines
" set fillchars+=vert:\│

" toggle set paste
set pastetoggle=<Leader>p

" Break lines at word boundaries when wrapping and wrap to previous indent
set linebreak
set breakindent

" enable syntax highlighting
" syntax enable

" show line numbers
set number
set relativenumber

" autoindent and tab options
" set autoindent
" set expandtab
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4

" put a line under the cursor
set cursorline

" show matching braces
" set showmatch
" hi MatchParen cterm=bold ctermbg=none ctermfg=red

" Smart case when searching
set ignorecase
set smartcase

" enable Python highlighting features
" let python_hightlight_all = 1

" Show sign column when signs are present (instead of overwriting line numbers)
set signcolumn=yes

" Show tab characters
" set list
" set listchars=tab:>-

" Markdown bindings
augroup mdbindings
  autocmd! mdbindings
  autocmd Filetype markdown noremap <buffer> <silent> k gk
  autocmd Filetype markdown noremap <buffer> <silent> j gj
  autocmd Filetype markdown noremap <buffer> <silent> 0 g0
  autocmd Filetype markdown noremap <buffer> <silent> $ g$
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd FileType markdown call lexical#init()
augroup end

"------------------------------------------------------------------------------------
"------ LSP Config ------
"------------------------------------------------------------------------------------

set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c


lua <<EOF
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
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
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

"------------------------------------------------------------------------------------
"------ Plug Configs ------
"------------------------------------------------------------------------------------

"------ NERDTree Config ------
map <C-n> :NERDTreeToggle<CR>
"
" close NERDTree when it's open by itself
" autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif

" Disable "Press ? for help
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" NERDTree Ignore
let NERDTreeIgnore=['__pycache__']
"
"------ Lightline Config ------
let g:lightline = {
      \   'colorscheme': 'onedark',
      \   'component_function': {
      \       'filename': 'FilenameLightline',
      \       'gitbranch': 'GitbranchLightline',
      \       'sessionstatus': 'SessionLightline',
      \       'zoom': 'ZoomLightline',
      \       'nearestfunc': 'NearestMethodOrFunction',
      \   },
      \   'component_expand': {
      \       'coc_error_status': 'COCErrorStatus',
      \       'coc_warning_status': 'COCWarningStatus'
      \   },
      \   'component_type': {
      \       'coc_error_status': 'error',
      \       'coc_warning_status': 'warning'
      \   },
      \   'separator': {'left': '', 'right': '' },
      \   'subseparator': {'left': '', 'right': '' },
      \   'active': {
      \     'left': [
      \         ['mode', 'paste'],
      \         ['gitbranch', 'readonly', 'filename','modified', 'nearestfunc', 'zoom', ],
      \         ['coc_error_status', 'coc_warning_status'],
      \     ],
      \     'right': [
      \         ['lineinfo'],
      \         ['percent'],
      \         ['sessionstatus', 'fileformat', 'fileencoding', 'filetype'],
      \     ]
      \   },
      \ }
set laststatus=2
set noshowmode
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Show full path of filename
function! FilenameLightline()
    return expand('%')
endfunction
"
" Show session status
function! SessionLightline()
    let status = ObsessionStatus()
    if empty(status)
        return ''
    elseif status == '[$]'
      return 'tracking'
    elseif status == '[S]'
      return 'paused'
    endif
    return status
endfunction

function! GitbranchLightline()
  if gitbranch#name() != ''
    return ' ' . gitbranch#name()
  else
    return ''
  endif
endfunction

" function! COCErrorStatus() abort
"   hi RedText ctermbg=grey ctermfg=red
"   let info = get(b:, 'coc_diagnostic_info', {})
"   if info['error']
"     return ' ' . info['error']
"   endif
"   return ''
" endfunction

" function! COCWarningStatus() abort
"   let info = get(b:, 'coc_diagnostic_info', {})
"   if info['warning']
"     return ' ' . info['warning']
"   endif
"   return ''
" endfunction

" Show zoom status
function! ZoomLightline()
    let status = zoom#statusline()
    return status
endfunction

" Show nearest method or function
function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

"------------------------------------------------------------------------------------
"------ Keyboard Config ------
"------------------------------------------------------------------------------------
" Control j and h to scroll
map <C-j> <C-E>
map <C-k> <C-Y>

" Change background to none
nnoremap <C-F> :highlight Normal ctermbg=none<CR>

" fzf Buffers
nnoremap <C-B> :Buffers<CR>

" Find and replace under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" nnoremap <Leader>d :%s/\<'<,'>\>/

" Clear hightlight after search
nnoremap <C-_> <Cmd>nohlsearch<CR>

nmap [g <Cmd>lua vim.diagnostic.goto_prev()<CR>
nmap ]g <Cmd>lua vim.diagnostic.goto_next()<CR>
nmap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nmap gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap K <cmd>lua vim.lsp.buf.hover()<CR>
nmap gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nmap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nmap <space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nmap <space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nmap <space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nmap <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nmap <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nmap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nmap gr <cmd>lua vim.lsp.buf.references()<CR>
nmap <space>f <cmd>lua vim.lsp.buf.formatting()<CR>
