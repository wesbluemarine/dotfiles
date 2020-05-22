let &t_Co=256
set t_Co=256
set termguicolors
set title
set number
set relativenumber
set cursorline
set ruler
set showmatch
set ignorecase
set incsearch
set hlsearch
set bs=2
set nobackup
set clipboard+=unnamedplus
set paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set go+=a

set encoding=utf-8

set diffopt+=iwhite " Ignore whitespace whilst diffing
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>
map <y> "+y<CR>

set list listchars=nbsp:¬,tab:»·,trail:·,extends:>
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noswapfile

syntax on
colorscheme gruvbox
set background=light
set undofile
set undodir=/tmp

set wildmode=longest,list,full
set wildmenu

"Recompile suckless programs automatically;
autocmd	BufWritePost config.h !make

"File name on Tmux
if exists('$TMUX')
    autocmd BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
    autocmd VimLeave * call system("tmux setw automatic-rename")
endif

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'morhetz/gruvbox'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
