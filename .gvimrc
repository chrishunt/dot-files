" .gvimrc

" set default font
set guifont=Inconsolata:h14

" set transparency
" set transparency=15

" remove toolbar and scrollbars from macvim
set guioptions-=T
set guioptions-=L
set guioptions-=r

" show console dialogs
set guioptions+=c

" bind Command-T to cmd+t
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif
