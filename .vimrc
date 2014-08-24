"Vim Settings
"@Author Shane Scanlon

" 1. System Settings
" 2. Global Key Bindings
" 3. Plugins
" 4. Functions
" 5. Display

"1.0 System Settings:
"------------------------------------------------------------
"Vundle - load plugins. Run command "vim +BundleInstall! +qa" {{{
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" }}}

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has("autocmd")
  filetype plugin indent on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Allow files to hide unsaved in buffers.
set hidden

" Better command-line completion
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" wildignorecase - :e document to become Document!
set wildignorecase

" Show partial commands in the last line of the screen
set showcmd

" Show matching brackets.
set showmatch

" Highlight searches
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Display line numbers relative to current line.
set relativenumber

" match on HTML/xml pairs
set matchpairs+=<:>     

" Set to auto read when a file is changed from the outside
set autoread

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%{fugitive#statusline()}%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" }}}

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab

" Be smart when using tabs ;)
set smarttab

"Folds 
set foldmethod=marker
set foldlevel=99 "folds open by default
set foldcolumn=3

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Files, backups {{{
set nobackup
set nowb
set noswapfile
" }}}

" For regular expressions turn magic on
set magic
" use very magic setting for search, and for replace
nnoremap / /\v
cnoremap %s/ %s/\v
cnoremap s/ s/\v


" 2. Global Key Bindings
"------------------------------------------------------------
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Use ctrl-[hjkl] to select the active split!
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" bclose - keeps windows when closing buffers
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Session management {{{
    " Save current session
    map <F1> :call SaveCurrentSession()<CR>
    " Attempt to load current session
    " autocmd vimenter * if !argc() && v:this_session == "" | exec "source ~/.vimsession" | endif
    map <F2> :source ~/.vimsession<CR>
"}}}

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Invisibles {{{
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" }}}

" 3. Plugins
"------------------------------------------------------------
" Nerdtree {{{
    Bundle 'scrooloose/nerdtree'
    let NERDTreeShowHidden=1 "show hidden files
    autocmd vimenter * if !argc() | NERDTree | endif " Open tree automatically if no files specified, and we haven't loaded from a session
    " f7 to open file explorer for nerdtree
    nmap <F7> :NERDTreeToggle<CR>
    " Ignore git directory, c object files, java class files, and others that we do not want displayed in the tree
    let NERDTreeIgnore=['.git$[[dir]]', '.o$[[file]]', '.class$[[file]]','.swp$[[file]]','.swo$[[file]]']
" }}}

"Tagbar {{{
Bundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
"}}}

" Syntastic! ...and I suppose eclim can go in here, these are similar{{{
Bundle 'scrooloose/syntastic'
let g:syntastic_java_javac_config_file_enabled=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
" }}}

" Extend bracket mappings, including [b, ]b for previous and next buffers
Bundle 'tpope/vim-unimpaired'

" Git commands!
Bundle 'tpope/vim-fugitive'

" MiniBufExplorer and buffer settings{{{
Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplBuffersNeeded=100 "hide screen until there are 100 buffers. Hoping this never happens. Essencially manual mode
let g:miniBufExplUseSingleClick = 1 "single click to swap
map <F6> :MBEToggleAll<cr>

" bclose - keeps windows when closing buffers
Bundle 'bcaccinolo/bclose'
"close buffer 
map <leader>d :Bclose!<cr> 

" autocomplete! see readme for details for installation. It's pretty awesome.
Bundle 'Valloric/YouCompleteMe'

" Strip trailing whitespace with <leader>$ {{{
nnoremap <leader>$ :call <SID>StripTrailingWhitespaces()<CR>

"clear search highlighting
nnoremap <leader>z :nohl<CR>

" 4. Functions
"------------------------------------------------------------
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! SaveCurrentSession()
    " Close nerd tree, it causes buffer issues
    exec "NERDTreeClose"
    " Create a session, if none exists
    if v:this_session == '' | let v:this_session = '~/.vimsession' | endif
    if v:this_session != '' | exec "mks! " . v:this_session | endif
    echo "session saved to " . v:this_session
endfunction

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" 5. Display
"------------------------------------------------------------
colorscheme desert
