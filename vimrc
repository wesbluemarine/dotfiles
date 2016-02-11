"Latex
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
let g:Tex_DefaultTargetFormat='pdf'


"Vim Stuff
set laststatus=2             "Always show the status bar and not on splited like before(this was the main problem)
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set shell=/usr/bin/zsh
set clipboard=unnamed
set paste
set gp+=a
set mouse=a
set gfn=PragmataPro\ for\ Powerline\ Bold\ 10

"Vim GUI Stuff
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

map <C-c> :!xclip -f -sel clip<CR>    
map <C-v>> :r !xclip -o -sel clip<CR>

execute pathogen#infect()
syntax on
filetype plugin indent on 

set number
set background=dark
colorscheme solarized


autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


map <C-n> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1


"Solarized-light in GUI
"if has('gui_running')
"	    set background=light
"    else
"	        set background=dark
"	endif
