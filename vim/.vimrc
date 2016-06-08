" Author: Kyle Galloway


"----- Install Plugins (Vundle) -----------------------------------------------"
set nocompatible                            " Disable vi-compatibility
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
let vundlepath='~/.vim/bundle'
let dotfiles_dir='~/Repos/dotfiles'

call vundle#begin(vundlepath)
Plugin 'vim-airline/vim-airline'           " Vim Airline
Plugin 'vim-airline/vim-airline-themes'    " Vim Airline
Plugin 'chriskempson/base16-vim'           " Base16 Color Schemes
Plugin 'ctrlpvim/ctrlp.vim'                " Ctrl-P
Plugin 'gmarik/Vundle.vim'                 " Vundle
Plugin 'rking/ag.vim'                      " Ag for Vim
Plugin 'SirVer/ultisnips'                  " UltiSnips
Plugin 'Valloric/YouCompleteMe'            " YouCompleteMe (linux only)

call vundle#end()
filetype plugin indent on


"----- Setup for LMCDL Workspace ----------------------------------------------"
let workspace = $WORKSPACE_BASE
set nobackup noswapfile         " Don't use swap/backup because we use GitHub
autocmd! bufwritepost .vimrc source %       " Autoreload vimrc on save


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


"----- Ctrl P ----------------------------------------------------------------"
set wildignore+=*/.build/*                   " Ignore files in .build
set wildignore+=*.moc                        " Ignore moc files
let g:ctrlp_dotfiles = 0                     " Ignore dotfiles
let g:ctrlp_switch_buffer = 0                "
let g:ctrlp_working_path_mode = 'rw'         " Helps play nice with NERDTree
let g:ctrlp_lazy_update = 1                  " Only update after typing finishes
let g:ctrlp_by_filename = 1                  " Search by filename instead of path
let g:ctrlp_root_markers = '.git'
if executable('ag')
   set grepprg=ag\ --nogroup\ --nocolor
   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


"----- Code Completions with ctags --------------------------------------------"
" Make sure you use ctags --fields=+l when generating them to work with YCM
set tags=$WORKSPACE_BASE/sw/tags,$QTDEPENZDIR/linux/tags,$ANUBISDEPENZDIR/tags,$VCSTOOLKITDEPENZDIR/tags,$MGCSDLIDEPENZDIR/tags,tags,./tags
nmap <leader>r <Esc>:silent !bash -lc "time retag"<CR>:redraw!<CR>


"----- Code Completions with YouCompleteMe ------------------------------------"
nnoremap <F5> :YcmForceCompileAndDiagnostics<cr>c
nnoremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<cr>
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = dotfiles_dir . "/vim/ycm_extra_conf.py"
let g:ycm_register_as_syntastic_checker = 1
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>


"----- UltiSnips --------------------------------------------------------------"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = "<c-s>"
let g:UltiSnipsJumpBackwardTrigger = "<left>"
let g:UltiSnipsJumpForwardTrigger  = "<right>"
let g:UltiSnipsListSnippets        = "<c-m-s>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/dotfiles/vim/UltiSnips']


"----- Leader Shortcuts -------------------------------------------------------"
let mapleader=","               " leader is comma
let g:mapleader = ","           " leader is comma in gvim
inoremap ,. <Esc>
vnoremap ,. <Esc>
inoremap jk <Esc>
vnoremap jk <Esc>
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
" We don't need arrow keys where we're going
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>
