set encoding=utf-8
scriptencoding utf-8

"------------------------------------------------------------------------------------
"------ Basic Config ------
"------------------------------------------------------------------------------------

"------ Command mode zsh-like autocompletion -------
set wildmode=longest:full,full
set wildmenu
set wildignore=*.o,*~
set wildignorecase

" Split panes open on the right or below
set splitright
set splitbelow

" Split panes use solid lines
set fillchars+=vert:\│

" toggle set paste
set pastetoggle=<Leader>p

" Break lines at word boundaries when wrapping and wrap to previous indent
set linebreak
set breakindent

" enable syntax highlighting
syntax enable

" show line numbers
set number
set relativenumber

" autoindent and tab options
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" put a line under the cursor
set cursorline

" show matching braces
set showmatch
hi MatchParen cterm=bold ctermbg=none ctermfg=red

" Smart case when searching
set ignorecase
set smartcase

" enable Python highlighting features
let python_hightlight_all = 1

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
"
" sh tabs
augroup shtabs
  autocmd! shtabs
  autocmd Filetype sh set tabstop=4
  autocmd Filetype sh set softtabstop=4
  autocmd Filetype sh set shiftwidth=4
augroup end

" set the cursor to a line in Normal Mode and a block in Insert Mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" switches to open tab for files which are already open
set switchbuf=usetab

" Scrolling COC hover popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"------ vim-polyglot config ------
set nocompatible
let g:polyglot_disabled = ['sh']

"------------------------------------------------------------------------------------
"------ vim-plug Config ------
"------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/goyo.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'preservim/vim-lexical'
Plug 'darfink/vim-plist'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter/'
Plug 'dhruvasagar/vim-zoom'
Plug 'liuchengxu/vista.vim'

call plug#end()

"------ onedark.vim Theme Config ------
colorscheme onedark

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
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

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

function! COCErrorStatus() abort
  hi RedText ctermbg=grey ctermfg=red
  let info = get(b:, 'coc_diagnostic_info', {})
  if info['error']
    return ' ' . info['error']
  endif
  return ''
endfunction

function! COCWarningStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if info['warning']
    return ' ' . info['warning']
  endif
  return ''
endfunction

" Show zoom status
function! ZoomLightline()
    let status = zoom#statusline()
    " if empty(status)
    "     return ''
    " elseif status == "zoomed"
    "   return 'Z'
    " endif
    return status
endfunction

" Show nearest method or function
function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

"------------------------------------------------------------------------------------
"------ Plugin Configuration ------
"------------------------------------------------------------------------------------
"------ vim_markdown Config ------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1

"------ Goyo Config ------
let g:goyo_width = 120
let g:goyo_height = '100%'

"------ coc-snippets Config ------
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

let g:coc_snippet_next = '<tab>'

"------ gopls Config ------
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 OR :silent call CocAction('runCommand', 'editor.action.organizeImport')

"------ go syntax Config ------
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

"------ vim-terraform Config ------
let g:terraform_fmt_on_save = 1

"------ gitgutter Config ------
" GitGutter diff base
function! GitGutterDiffBranch(branch_name)
    let g:gitgutter_diff_base = a:branch_name
    GitGutter
endfunction

function! ListBranches(A,L,P)
  return system("git branch --list | sed 's/^[* ] //g' | cat <<< 'HEAD'")
endfunction

command! -nargs=1 -complete=custom,ListBranches GitGutterDiffBranch :call GitGutterDiffBranch(<f-args>)

nmap <Leader>d :GitGutterDiffBranch 

"------ vim-obsession Config ------
function! s:obsession_toggle()
  if ObsessionStatus() == '[$]'
    :Obsession
  else
    :Obsession .session.vim
  endif
endfunction

nnoremap <C-s> call s:obsession_toggle()<CR>

"------ vista Config ------
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
map <C-l> :Vista finder<CR>

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

"------ vim-zoom Config ------
nmap <C-W>z <Plug>(zoom-toggle)
"

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

"------------------------------------------------------------------------------------
"------ COC Config ------
"------------------------------------------------------------------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Get outline of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Formatting
command! -nargs=0 Format :call CocAction('format')
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Custom coc bindings
nmap <leader>r  <Plug>(coc-rename)

source ~/.dotfiles/.vimrc-dev
