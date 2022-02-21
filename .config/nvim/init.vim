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
Plug 'RishabhRD/popfix'
Plug 'hood/popui.nvim' "Depends on popfix
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" From vim
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'preservim/vim-lexical'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dhruvasagar/vim-zoom'
Plug 'onsails/lspkind-nvim'
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

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
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

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

set completeopt=menuone,noselect

" Avoid showing extra messages when using completion
set shortmess+=c


lua <<EOF
----------------------------
-- Rust Config
-- See https://github.com/simrat39/rust-tools.nvim#configuration
----------------------------
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = false,
        hover_with_actions = true,
        inlay_hints = {
            -- only_current_line = true,
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

----------------------------
-- Defaul LSP Config
----------------------------
require'lspconfig'.bashls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.jedi_language_server.setup{}

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.diagnosticls.setup{
    on_attach = on_attach,
--     capabilities = lsp_status.capabilities,
    cmd = {"diagnostic-languageserver", "--stdio"},
    filetypes = {
            "c",
            "cpp",
            "css",
            "html",
            "json",
            "python",
            "sh",
            "yaml"
    },
    init_options = {
        filetypes = {
            python = "pylint",
            sh = "shellcheck",
            vim = "vint"
        },
        linters = {
            pylint = {
                sourceName = "pylint",
                command = "pylint",
                args = {
                    "--init-hook='import pylint_venv; pylint_venv.inithook()'",
                    "--output-format",
                    "text",
                    "--score",
                    "no",
                    "--msg-template",
                    "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'",
                    "%file"
                },
                formatPattern = {
                    "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4
                    }
                },
                rootPatterns = {
                    ".git",
                    "pyproject.toml",
                    "setup.py"
                },
                securities = {
                    informational = "hint",
                    refactor = "info",
                    convention = "info",
                    warning = "warning",
                    error = "error",
                    fatal = "error"
                },
                offsetColumn = 1,
                formatLines = 1
            }
        },
        formatFiletypes = {
            c = "clang_format",
            cpp = "clang_format",
            css = "prettier",
            html = "prettier",
            json = "prettier",
            python = {
                "black",
                "isort"
            },
            sh = "shfmt",
            yaml = "prettier"
        },
        formatters = {
            black = {
                command = "black"
            },
            clang_format = {
                command = "clang-format",
                args = {"--style=LLVM"}
            },
            shfmt = {
                command = "shfmt",
                args = {"-i", "2"}
            }
        },
    }
} 
require'lspconfig'.sqls.setup{}

----------------------------
-- CMP Config
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
----------------------------
local cmp = require'cmp'
local lspkind = require('lspkind')
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

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
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

vim.diagnostic.config{
    virtual_text=false, -- Disable virtual text
    severity_sort = true,
}
vim.ui.select = require"popui.ui-overrider" -- PopUI
vim.ui.input = require"popui.ui-input-override" -- PopUI

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Information = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.o.signcolumn = 'yes'

----------------------------
-- Lualine config
----------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
      lualine_a = {{'mode', color = {gui='bold'}}},
    lualine_b = {
        'branch',
        },
    lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
            },
            {
                'diagnostics',
                symbols = {error = ' ', warn = ' '}
            }
    },
    lualine_x = {
        '%{ObsessionStatus("tracking", "paused")}',
        'encoding',
        'fileformat',
        {'filetype', colored = false}
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
            {
                'filename',
                path = 1,
            }
        },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
      },
  extensions = {}
}
EOF

augroup formatOnSave
    autocmd! formatOnSave
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
    autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
    autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
    " autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup end

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

"------ Vista Config ------
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_default_executive = 'nvim_lsp'
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
map <C-l> :Vista finder<CR>

"------------------------------------------------------------------------------------
"------ Keyboard Config ------
"------------------------------------------------------------------------------------
" Control j and h to scroll
map <C-j> <C-E>
map <C-k> <C-Y>

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
