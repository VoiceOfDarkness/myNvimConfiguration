" PLUGINS ------------------------------------------------------------------ {{{
call plug#begin()
  " File Navigation
  Plug 'preservim/nerdtree'
  
  " Theme
  Plug 'olimorris/onedarkpro.nvim'
  
  " Treesitter for Syntax Highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  
  " Automatic Closing of Quotes, Parentheses, etc.
  Plug 'Raimondi/delimitMate'
  
  " Auto-completion
  Plug 'hrsh7th/nvim-compe'
  
  " Statusline
  Plug 'nvim-lualine/lualine.nvim'
call plug#end()

" }}} 

" BASIC SETTINGS ----------------------------------------------------------- {{{
set nocompatible
filetype on
filetype plugin on
filetype indent on

set termguicolors
syntax enable
set background=dark
colorscheme onedark

set number
set cursorline
set shiftwidth=4
set tabstop=4
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set completeopt=menuone,noselect
set listchars=tab:··
set list

" Resizing split windows using arrow keys
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Map F5 key to run a Python script inside Vim
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" NERDTree specific mappings
nnoremap <F3> :NERDTreeToggle<cr>

set mouse=a

nnoremap <F6> :call ToggleMouse()<CR>
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        echo "Mouse usage disabled"
    else
        set mouse=a
        echo "Mouse usage enabled"
    endif
endfunction

" Treesitter setup
lua << EOF
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  }
})
EOF

" Lualine setup
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'ayu_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
END

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" Enable the marker method of folding
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" HTML specific settings
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" Undo settings
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" Compe plugin settings
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

" GUI specific settings
if has('gui_running')
    set background=dark
    set guifont=Monospace\ Regular\ 12
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set guioptions-=b
    
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>
endif

" }}}
