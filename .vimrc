" .vimrc

" don't need to be compatible with old vim
set nocompatible

" show line numbers
set nu

" we have a dark background
colorscheme vividchalk
set background=dark

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

" enable mouse support
set mouse=a

" remove toolbar and scrollbars from macvim
set guioptions-=T
set guioptions-=L
set guioptions-=r
