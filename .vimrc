" .vimrc

" set default font
set guifont=Inconsolata:h14

" don't need to be compatible with old vim
set nocompatible

" show line numbers
set nu

" show row and column in footer
set ruler

" minimum lines above/below cursor
set scrolloff=2

" disable code folding
set nofoldenable

" toggle spellcheck with <F5>
:map <F5> :setlocal spell! spelllang=en_au<cr>
:imap <F5> <ESC>:setlocal spell! spelllang=en_au<cr>

" we have a dark background
colorscheme vividchalk
set background=dark
set transparency=25

" show syntax highlighting
syntax on

" set auto indent
set autoindent
filetype plugin indent on

" set indent to 2 spaces and expand
set ts=2
set shiftwidth=2
set expandtab

" show bracket matches
set showmatch

" ignore case in search
set ignorecase

" pay attention to case when caps are used
set smartcase

" show search results as I type
set incsearch

" enable mouse support
set mouse=a

" remove toolbar and scrollbars from macvim
set guioptions-=T
set guioptions-=L
set guioptions-=r

" enable visual bell (disable audio bell)
set vb

" highlight long lines
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/

" LaTeX options
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
