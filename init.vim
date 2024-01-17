"PLUGINS ---------------------------------------------------------------- {{{ 
call plug#begin() 
  Plug 'preservim/nerdtree' 
  Plug 'olimorris/onedarkpro.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'Raimondi/delimitMate'
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-lualine/lualine.nvim'
call plug#end() 
 
" }}} 
" Disable compatibility with vi which can cause unexpected issues. 
set nocompatible 
" Enable type file detection. Vim will be able to try to detect the type of file in use. 
filetype on 
" Enable plugins and load plugin for the detected file type. 
filetype plugin on 
" Load an indent file for the detected file type. 
filetype indent on 
set termguicolors 
" Turn syntax highlighting on. 
syntax enable 
set background=dark 
colorscheme onedark 
" Add numbers to each line on the left-hand side. 
set number 
" Highlight cursor line underneath the cursor horizontally. 
set cursorline 
" Set shift width to 4 spaces. 
set shiftwidth=4 
" Set tab width to 4 columns. 
set tabstop=4 
" Do not save backup files. 
set nobackup 
" Do not let cursor scroll below or above N number of lines when scrolling. 
set scrolloff=10 
" Do not wrap lines. Allow long lines to extend as far as the line goes. 
set nowrap 
" While searching though a file incrementally highlight matching characters as you type. 
set incsearch 
" Ignore capital letters during search. 
set ignorecase 
" Override the ignorecase option if searching for capital letters. 
" This will allow you to search specifically for capital letters. 
set smartcase 
" Show partial command you type in the last line of the screen. 
set showcmd 
" Show the mode you are on the last line. 
set showmode 
" Show matching words during a search. 
set showmatch 
" Use highlighting when doing a search. 
set hlsearch 
" Set the commands to save in history default number is 20. 
set history=1000 
" Enable auto completion menu after pressing TAB. 
set wildmenu 
" Make wildmenu behave like similar to Bash completion. 
set wildmode=list:longest 
" There are certain files that we would never want to edit with Vim. 
" Wildmenu will ignore files with these extensions. 
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 

set completeopt=menuone,noselect

" Resize split windows using arrow keys by pressing: 
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT. 
noremap <c-up> <c-w>+ 
noremap <c-down> <c-w>- 
noremap <c-left> <c-w>> 
noremap <c-right> <c-w>< 
 
" Map the F5 key to run a Python script inside Vim. 
" I map F5 to a chain of commands here. 
" :w saves the file. 
" <CR> (carriage return) is like pressing the enter key. 
" !clear runs the external clear screen command. 
" !python3 % executes the current file with Python. 
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR> 
 
" NERDTree specific mappings. 
" Map the F3 key to toggle NERDTree open and close. 
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

lua << EOF
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  }
})
EOF

lua << END
require('lualine').setup()
END

" VIMSCRIPT -------------------------------------------------------------- {{{ 
 
" Enable the marker method of folding. 
augroup filetype_vim 
    autocmd! 
    autocmd FileType vim setlocal foldmethod=marker 
augroup END 
 
" If the current file type is HTML, set indentation to 2 spaces. 
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab 
 
" If Vim version is equal to or greater than 7.3 enable undofile. 
" This allows you to undo changes to a file even after saving it. 
if version >= 703 
    set undodir=~/.vim/backup 
    set undofile 
    set undoreload=10000 
endif 

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

" You can split a window into sections by typing :split or :vsplit. 
" Display cursorline and cursorcolumn ONLY in active window. 
 
" If GUI version of Vim is running set these options. 
if has('gui_running') 
 
    " Set the background tone. 
    set background=dark 
 
    " Set the color scheme. 
 
    " Set a custom font you have installed on your computer. 
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size> 
    set guifont=Monospace\ Regular\ 12 
 
    " Display more of the file by default. 
    " Hide the toolbar. 
    set guioptions-=T 
 
    " Hide the the left-side scroll bar. 
    set guioptions-=L 
 
    " Hide the the right-side scroll bar. 
    set guioptions-=r 
 
    " Hide the the menu bar. 
    set guioptions-=m 
 
    " Hide the the bottom scroll bar. 
    set guioptions-=b 
 
    " Map the F4 key to toggle the menu, toolbar, and scroll bar. 
    " <Bar> is the pipe character. 
    " <CR> is the enter key. 
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar> 
        \set guioptions-=mTr<Bar> 
        \else<Bar> 
        \set guioptions+=mTr<Bar> 
        \endif<CR> 
 
endif 
 
" }}}
