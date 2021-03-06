" Author: Kyle Galloway
" Attributions: Joshua Durham, Mac Clayton, Joseph P. Creekmore, Adam Chesney

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN VUNDLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                            " Disable vi-compatibility
filetype off

if has("win32")
   set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
   let vundlepath='$HOME/vimfiles/bundle/'
   let dotfiles_dir='$HOME/Repos/dotfiles'
   behave mswin
   source $VIMRUNTIME/mswin.vim
else
   set rtp+=~/.vim/bundle/Vundle.vim
   let vundlepath='$HOME/.vim/bundle'
   let dotfiles_dir='$HOME/Repos/dotfiles'
endif

call vundle#begin(vundlepath)
" Vundle
Plugin 'gmarik/Vundle.vim'                 " Let Vundle manage itself

" Plugins
Plugin 'ain/vim-npm'                       " Adds Npm commands
Plugin 'mhinz/vim-signify'                 " Adds source control gutter
Plugin 'tpope/vim-commentary'              " Vim Commentary
Plugin 'Valloric/vim-indent-guides'        " See the spaces (and tabs)
Plugin 'vim-airline/vim-airline'           " Vim Airline
Plugin 'vim-airline/vim-airline-themes'    " Vim Airline Themes
Plugin 'dbeniamine/todo.txt-vim'           " Todo.txt plugin
Plugin 'rust-lang/rust.vim'                " Rust file detection, syntax highlighting, formatting, etc.
Plugin 'editorconfig/editorconfig-vim'     " EditorConfig integration
Plugin 'leafgarland/typescript-vim'        " Typescript support

call vundle#end()
filetype plugin indent on
" Vundle Help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins
" :PluginUpdate - updates plugins
" :PluginSearch <foo> - searches for <foo>
" :PluginClean - removes unused plugins
" :h vundle for more

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF - Fuzzy Finder
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.fzf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader Shortcuts - keep at top
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","               " leader is comma
let g:mapleader = ","           " leader is comma in gvim
" Remap all combos of j & k to be escape seq.
" Then, move to position after so it acts like expected.
inoremap kj <esc>l
vnoremap kj <esc>l
inoremap kJ <esc>l
vnoremap kJ <esc>l
inoremap KJ <esc>l
vnoremap KJ <esc>l
inoremap Kj <esc>l
vnoremap Kj <esc>l
inoremap jk <esc>l
vnoremap jk <esc>l
inoremap jK <esc>l
vnoremap jK <esc>l
inoremap JK <esc>l
vnoremap JK <esc>l
inoremap Jk <esc>l
vnoremap Jk <esc>l
nmap <leader>w :w!<CR>          " leader-w is fast saves

"Auto change directory to match current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Map the buffer movement keys to ctrl + the regular movement keys
" (It's way easier to switch buffers this way)
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
" Down is really the next line
nnoremap j gj
nnoremap k gk

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Gui
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256                    " Enable full colors
syntax enable                   " Enable syntax highlighting
if has("gui_running")
   if has("gui_gtk2")                  " Setup Linux Font
      set guifont=Inconsolata\ for\ Powerline\ Medium\ 13
   elseif has("gui_macvim")            " Setup Mac OSX Font
      set guifont=Menlo\ Regular:h14
   elseif has("gui_win32")             " Setup Windows Font
      set guifont=Inconsolata_for_Powerline:h12:cANSI
   else
      set guifont=Inconsolata\ for\ Powerline\ Medium\ 13
   endif
endif
set guioptions-=T               " Removes top toolbar
set guioptions-=r               " Removes right hand scroll bar
set go-=L                       " Removes left hand scroll bar
set background=dark
" set mouse=a                   " enable the mouse
set mouse=                      " disable the mouse
set number                      " always show line numbers
set showmatch                   " highlight matching [{()}]

set colorcolumn=121             " Sets a color column at 121 characters
match ErrorMsg '\%>121v.\+'     " Makes things past 121 characters look like errors


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spaces, Tabs, and Other Vim things
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set lazyredraw                  " don't update screen inside macros, etc
set gdefault                    " s///g by default
set autoread                    " reload changed files
set cursorline                  " Highlight current line

" Make ; be the same as : in normal mode
nnoremap ; :
autocmd BufWritePre *.cxx :%s/\s\+$//e    " Auto-remove trailing spaces for cxx on save
autocmd BufWritePre *.py :%s/\s\+$//e    " Auto-remove trailing spaces for py on save
autocmd BufWritePre *.js :%s/\s\+$//e    " Auto-remove trailing spaces for js on save
autocmd BufWritePre *.ts :%s/\s\+$//e    " Auto-remove trailing spaces for ts on save
autocmd BufWritePre *.css :%s/\s\+$//e    " Auto-remove trailing spaces for css on save
autocmd BufWritePre *.less :%s/\s\+$//e    " Auto-remove trailing spaces for less on save
autocmd BufWritePre *.html :%s/\s\+$//e    " Auto-remove trailing spaces for html on save
autocmd BufWritePre *.h :%s/\s\+$//e      " Auto-remove trailing spaces for headers on save
autocmd BufWritePre *.vimrc :%s/\s\+$//e  " Auto-remove trailing spaces for vimrc on save

" Don't autocomment when adding a new line after a comment
augroup DisableAutoComments
   autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

set nobackup noswapfile         " Don't use swap/backup
" autocmd! bufwritepost .vimrc source %       " Autoreload vimrc on save



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set hlsearch incsearch
" Use <leader><space> to clear searches
nmap <silent> <leader><space> :nohlsearch<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden                          " Allows buffers to be hidden when modified
nmap <leader>T :enew<CR>            " To open a new empty buffer
nmap <leader>h :bprevious<CR>       " Move to the previous buffer
nmap <leader>l :bnext<CR>           " Move to the next buffer



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Screen Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap vs :vsplit<CR>
nmap hs :split<CR>
set splitright " Open splits on the right
set splitbelow " Open splits at the bottom


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Typescript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:typescript_indent_disable = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Signify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_vcs_list = [ 'git', 'tfs' ]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_column_always = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Todotxt
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:TodoTxtStripDoneItemPriority=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Built-in
" colorscheme blue
" colorscheme default
" colorscheme desert
" colorscheme evening
" colorscheme koehler
" colorscheme murphy
" colorscheme peachpuff
" colorscheme ron
" colorscheme slate
" colorscheme zellner
" colorscheme darkblue
" colorscheme delek
" colorscheme elflord
" colorscheme industry
" colorscheme morning
" colorscheme pablo
" colorscheme shine
" colorscheme torte



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>/ :Commentary<cr>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'base16'
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled  = 1
let g:airline#extensions#tabline#enabled = 1 "Show buffers when only one tab open
let g:airline#extensions#bufferline#enabled = 1 "Show buffer line
set laststatus=2 "Show airline even when no splits are open



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makes long lines appear in error highlighting.
function! ColorizeBadStyles()
   set colorcolumn=121
   match ErrorMsg '\%>121v.\+'
endfunction

command! ColorizeBadStyles call ColorizeBadStyles()
nnoremap <silent> <F3> :call ColorizeBadStyles()<CR>

" Surround a word in quotes
nnoremap <leader>' viw<esc>a"<esc>hbi"<esc>"lel

" Put a semicolon at the end of the current line without moving cursor
nnoremap <leader>; mqA;<esc>`q

" Drop in <n> number of git log commit messages
" Make sure you are on a new line as this replaces the line your cursor is on
function! Gitlog(n)
   let cmd = ".!git log --oneline -n " . a:n
   execute cmd
endfunction
command! -nargs=1 Gitlog call Gitlog(<f-args>)
command! -nargs=1 Gl call Gitlog(<f-args>)

" Put a semicolon at the end of \a line_number without moving cursor
function! Semi(line_number)
   let cmd = "normal! mp" . a:line_number . "GmqA;\<esc>`q`p"
   execute cmd
endfunction
command! -nargs=1 Semi call Semi(<f-args>)

" Toggle the linenumbers between relative and not
function! ToggleNumberMode()
   if(&relativenumber==1)
      setlocal norelativenumber
   else
      setlocal relativenumber
   endif
endfunction
nnoremap <silent> <F4> :call ToggleNumberMode()<CR>

" For editing the vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" For when you forget to sudo, you can still write with w!!
cmap w!! %!sudo tee > /dev/null %

" search for merge comments
nmap <leader>gm /=======\\|>>>>>>>\\|<<<<<<<<CR>

" Instead of toggling Upper to Lower, ~ will now toggle through Upper, Lower and Title cases
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgvl

" Insert the current date or time
" Date
:nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P
:inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
" Date and Time
:nnoremap <F6> "=strftime("%Y-%m-%d %X")<CR>P
:inoremap <F6> <C-R>=strftime("%Y-%m-%d %X")<CR>

" Edit todo.txt
nnoremap <leader>td :vsplit $HOME/Repos/todo/todo.txt<CR>

" Loads of undo
" if v:version >= 703
"    set undofile
"    set undodir=/tmp
" endif

" Format C++ code with clang-format on save
function! ClangFormat()
   let l:formatdiff = 1
   py3file /usr/share/clang/clang-format-6.0/clang-format.py
endfunction
autocmd BufWritePre *.h,*.hpp,*.cc,*.cpp call ClangFormat()
