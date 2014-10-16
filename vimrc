"
"	Christian Sherland
"	    .vimrc
"
"

" Use vim - no vi defaults
set nocompatible

" Setting up Vundle - the vim plugin bundler
let hasVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let hasVundle=0
endif

" Vundle plugin management
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'kien/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
call vundle#end()
filetype plugin indent on

" ...All your other bundles...
if hasVundle == 0
  echo "Installing Plugins, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

" Better color stuff
syntax enable
set background=dark
colorscheme solarized
let g:solarized_contrast = "high"

" Time savers
let mapleader=","
nnoremap ; :

" Fix wrapping behavior when moving
nmap j gj
nmap k gk

" ANTI-TEMPTATION (need to figure something better out for up + down)
ino <Up> <NOP>
ino <Right> <NOP>
ino <Down> <NOP>
ino <Left> <NOP>

" move to beginning/end of line
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

" Moving between buffers
nmap <C-m> :bnext<CR>
nmap <C-b> :bprev<CR>
nmap <C-x> :bd<CR>
set hidden  " Switch buffers without saving

" Options dealing with search
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap <silent> <leader>/ :nohlsearch<CR>

" Location highlighting
set colorcolumn=80
set cursorline
set number          " Line numbers
set ruler           " Column number
set encoding=utf-8  " Default UTF-8 encoding

" Show command in bottom bar
set showcmd
set wildmenu

" Some editing preferences (tabs,  etc)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set autoindent
set smartindent
set copyindent
set showmatch
set smarttab
set nofoldenable

function! SetAltPrefs()
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
endfunction

" Copy to clipboard
map <C-c> "+y<CR>

" Set information on history
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class

" Terminal setting
set title
set visualbell
set noerrorbells

" Dont allow vim to make backups
set nobackup
set noswapfile

" INDENTING BLOCKS (retains vis. selection)
vnoremap > >gv
vnoremap < <gv

" Navigating between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable the use of the mouse
set mouse=a

" Add file-type specific options
au BufNewFile,BufRead *.mu set filetype=html syntax=mustache
au BufNewFile,BufRead *.json set filetype=javascript
au BufNewFile,BufRead *.css set synmaxcol=120
au BufEnter *.css set nowrap
autocmd filetype xml, html, xhtml, javascript call setAltPrefs()

" Forgot to sudo? No problem!
cmap w!! w !sudo tee % >/dev/null

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :source $MYVIMRC<CR>

" Easy mapping to kill trailing whitespace
nmap <silent> <leader>fw :FixWhitespace<CR>

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" Syntastic
function! ToggleErrors()
  let old_last_winnr = winnr('$')
  lclose
  if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
    Errors
  endif
endfunction
nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>

nmap <silent> <leader>stm :SyntasticToggleMode<CR>
highlight SyntasticErrorSign guifg=white guibg=red
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args ="--config ~/.jshintrc"

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" Fugitive
nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gb :Gblame<CR>
nmap <silent> <leader>gl :Glog<CR>
nmap <silent> <leader>gp :Git push<CR>

" Weird colors for gitgutter, etc
hi clear SignColumn
