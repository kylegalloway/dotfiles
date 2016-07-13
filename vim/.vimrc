" Author: Kyle Galloway

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
   let vundlepath='~/.vim/bundle'
   let dotfiles_dir='~/Repos/dotfiles'
endif

call vundle#begin(vundlepath)
Plugin 'airblade/vim-gitgutter'            " Displays gitgutter
Plugin 'chriskempson/base16-vim'           " Base16 Color Schemes
Plugin 'ctrlpvim/ctrlp.vim'                " Ctrl-P
Plugin 'gmarik/Vundle.vim'                 " Vundle
Plugin 'rking/ag.vim'                      " Ag for Vim
Plugin 'SirVer/ultisnips'                  " UltiSnips
Plugin 'terryma/vim-multiple-cursors'      " Multiple Cursors
Plugin 'tpope/vim-commentary'              " Vim Commentary
Plugin 'vim-airline/vim-airline'           " Vim Airline
Plugin 'vim-airline/vim-airline-themes'    " Vim Airline
Plugin 'racer-rust/vim-racer'              " Rust auto completer
Plugin 'rust-lang/rust.vim'                " Rust maintained plugin
if has("unix")
   Plugin 'Valloric/YouCompleteMe'            " YouCompleteMe (linux only)
endif

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spaces & Tabs
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
" Make ; be the same as : in normal mode
nnoremap ; :
autocmd BufWritePre *.cxx :%s/\s\+$//e    " Auto-remove trailing spaces for cxx on save
autocmd BufWritePre *.h :%s/\s\+$//e      " Auto-remove trailing spaces for headers on save
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "No auto-comment on next line


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set hlsearch incsearch
" Use <leader><space> to clear searches
nmap <silent> <leader><space> :noh<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'base16'
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled  = 1
let g:airline#extensions#tabline#enabled = 0 "Show buffers when only one tab open
let g:airline#extensions#bufferline#enabled = 0 "Don't show buffer line
set laststatus=2 "Show airline even when no splits are open



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl P
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*/.build/*                   " Ignore files in .build
set wildignore+=*.moc                        " Ignore moc files
let g:ctrlp_dotfiles = 0                     " Ignore dotfiles
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_lazy_update = 1                  " Only update after typing finishes
let g:ctrlp_by_filename = 1                  " Search by filename instead of path
let g:ctrlp_root_markers = '.git'
if executable('ag')
   set grepprg=ag\ --nogroup\ --nocolor
   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code Completions with ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make sure you use ctags --fields=+l when generating them to work with YCM
set tags=$HOME/Repos
nmap <leader>r <Esc>:silent !bash -lc "time retag"<CR>:redraw!<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code Completions with YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = dotfiles_dir . "/vim/ycm_extra_conf.py"
" change to 1 when syntastic added
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_select_completion = ['<C-h>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-l>', '<Up>']
nnoremap <F5> :YcmForceCompileAndDiagnostics<cr>c
nnoremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<cr>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_column_always = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>/ :Commentary<cr>
vnoremap <leader>/ :Commentary<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<left>"
let g:UltiSnipsJumpForwardTrigger  = "<right>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsSnippetDirectories=[dotfiles_dir . '/vim/UltiSnips']


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader Shortcuts
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
nmap <leader>w :w!<cr>          " leader-w is fast saves

"Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden                          " Allows buffers to be hidden when modified
nmap <leader>T :enew<cr>            " To open a new empty buffer
nmap <leader>h :bprevious<CR>       " Move to the previous buffer

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
noremap <leader>bq <c-^> :bd #<cr>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Screen Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Resize vsplit
nmap <C-v> :vertical resize +5<cr>
nmap 25 :vertical resize 40<cr>
nmap 50 <c-w>=
nmap 75 :vertical resize 120<cr>
nmap vs :vsplit<cr>
nmap hs :split<cr>
set splitright " Open splits on the right
set splitbelow " Open splits at the bottom


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map the buffer movement keys to ctrl + the regular movement keys
" (It's way easier to switch buffers this way)
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
" Down is really the next line
nnoremap j gj
nnoremap k gk


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Multiple Cursors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++ Specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" navigate between fake/implementation
map <F5> <Esc>:pyfile ~/.vim/python/toggleFake.py<CR>
" navigate between abstract/implementation
map <F6> <Esc>:pyfile ~/.vim/python/toggleAbstract.py<CR>
" switch between header/source with F7
map <F7> :e %:p:s,.h$,.X123X,:s,.cxx$,.h,:s,.X123X$,.cxx,<CR>
" navigate between test/implementation
map <F8> <Esc>:pyfile ~/.vim/python/toggleTest.py<CR>

function! Retag()
   :!cd $HOME/Repos; ctags -R
endfunction
command! Retag call Retag()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makes long lines appear in error highlighting.
function! ColorizeBadStyles()
   set colorcolumn=100
   match ErrorMsg '\%>99v.\+'
endfunction

command! ColorizeBadStyles call ColorizeBadStyles()
nnoremap <silent> <F3> :call ColorizeBadStyles()<CR>

" Don't autocomment when adding a new line after a comment
augroup DisableAutoComments
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

" Surround a word in quotes
nnoremap <leader>' viw<esc>a"<esc>hbi"<esc>"lel

" Put a semicolon at the end of the current line without moving cursor
nnoremap <leader>; mqA;<esc>`q

" Put a semicolon at the end of \a line_number without moving cursor
" Not sure how this works...see JDD
function! Semi(line_number)
   let cmd = "normal! mp" . a:line_number . "GmqA;\<esc>`q`p"
   execute cmd
endfunction

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
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" For when you forget to sudo, you can still write with w!!
cmap w!! %!sudo tee > /dev/null %

" Disable Q, because let's face it that was an accident
noremap Q <Nop>
noremap q <Nop>

" search for merge comments
nmap <leader>gm /=======\\|>>>>>>>\\|<<<<<<<<CR>
