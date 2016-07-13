" Author: Kyle Galloway


"----- Install Plugins (Vundle) -----------------------------------------------"
set nocompatible                            " Disable vi-compatibility
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
let vundlepath='~/.vim/bundle'
let dotfiles_dir='~/Repos/dotfiles'

call vundle#begin(vundlepath)
Plugin 'chriskempson/base16-vim'           " Base16 Color Schemes
Plugin 'gmarik/Vundle.vim'                 " Vundle
Plugin 'racer-rust/vim-racer'              " Rust auto completer
Plugin 'rking/ag.vim'                      " Ag for Vim
Plugin 'rust-lang/rust.vim'                " Rust maintained plugin
Plugin 'SirVer/ultisnips'                  " UltiSnips
Plugin 'tpope/vim-commentary'              " Comment lines using 'gcc' or 'gc*'
Plugin 'vim-airline/vim-airline'           " Vim Airline
Plugin 'vim-airline/vim-airline-themes'    " Vim Airline

call vundle#end()
filetype plugin indent on


"----- Setup Gui --------------------------------------------------------------"
set t_Co=256                    " Enable full colors
syntax enable                   " Enable syntax highlighting
if has("gui_running")
   if has("gui_gtk2")                  " Setup Linux Font
      set guifont=Inconsolata\ for\ Powerline\ Medium\ 13
   endif
endif
set guioptions-=T               " Removes top toolbar
set guioptions-=r               " Removes right hand scroll bar
set go-=L                       " Removes left hand scroll bar
set background=dark
colorscheme base16-default
set mouse=a                     " enable the mouse
set number                      " always show line numbers
set showmatch                   " highlight matching [{()}]
set colorcolumn=100             " Sets a color column at 100 lines


"----- Spaces & Tabs ----------------------------------------------------------"
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " number of visual spaces per TAB
set smarttab
set softtabstop=4               " number of spaces in tab when editing
set expandtab                   " tabs are spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set smartindent                 " use intelligent indention for C/C++
set copyindent                  " copy the previous indentation on autoindenting
set timeout timeoutlen=200 ttimeoutlen=100
set novisualbell                " don't flash screen
set noerrorbells                " don't beep
set autowrite                   " Save on buffer switch
" Make ; be the same as : in normal mode
nnoremap ; :
autocmd BufWritePre *.cxx :%s/\s\+$//e    " Auto-remove trailing spaces for cxx on save
autocmd BufWritePre *.h :%s/\s\+$//e      " Auto-remove trailing spaces for headers on save
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "No auto-comment on next line


"----- Searching -------------------------------------------------------------"
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set hlsearch incsearch
nmap <silent> <leader>/ :nohlsearch<CR> " Use <leader>/ to clear searches


"----- Airline ---------------------------------------------------------------"
let g:airline_theme = 'base16'
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled  = 1
let g:airline#extensions#syntastic#enabled  = 1
let g:airline#extensions#tabline#enabled = 1 "Show buffers when only one tab open
set laststatus=2 "Show airline even when no splits are open


"----- UltiSnips --------------------------------------------------------------"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = "<c-s>"
let g:UltiSnipsJumpBackwardTrigger = "<left>"
let g:UltiSnipsJumpForwardTrigger  = "<right>"
let g:UltiSnipsListSnippets        = "<c-m-s>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/dotfiles/vim/UltiSnips']


"----- Rust ------------------------------------------------------------------"
let g:rustfmt_autosave = 1 "Autoformats rust on save


"----- Leader Shortcuts -------------------------------------------------------"
let mapleader=","               " leader is comma
let g:mapleader = ","           " leader is comma in gvim
inoremap ,. <Esc>
vnoremap ,. <Esc>
inoremap jk <Esc>l
inoremap Jk <Esc>l
inoremap JK <Esc>l
inoremap jK <Esc>l
nmap <leader>w :w!<cr>          " leader-w is fast saves

"Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


"----- Buffers ----------------------------------------------------------------"
set hidden                          " Allows buffers to be hidden when modified
nmap <leader>T :enew<cr>            " To open a new empty buffer
nmap <leader>h :bprevious<CR>       " Move to the previous buffer

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
noremap <leader>bq <c-^> :bd #<cr>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>


"----- Screen Splits --------------------------------------------------------"
" Resize vsplit
nmap <C-v> :vertical resize +5<cr>
nmap 25 :vertical resize 40<cr>
nmap 50 <c-w>=
nmap 75 :vertical resize 120<cr>
nmap vs :vsplit<cr>
nmap hs :split<cr>
set splitright " Open splits on the right
set splitbelow " Open splits at the bottom


"----- Movement ---------------------------------------------------------------"
" Map the buffer movement keys to ctrl + the regular movement keys
" (It's way easier to switch buffers this way)
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
" Down is really the next line
nnoremap j gj
nnoremap k gk
