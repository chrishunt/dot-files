" .vimrc
set encoding=utf-8

" Load up vim-plug
call plug#begin('~/.vim/plugged')
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'epmatsw/ag.vim'
  Plug 'godlygeek/tabular'
  Plug 'janko/vim-test'
  Plug 'kchmck/vim-coffee-script'
  Plug 'mattn/webapi-vim'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'vimwiki/vimwiki'
call plug#end()

syntax on                         " show syntax highlighting
filetype plugin indent on
set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set termguicolors                 " show me all the colors please
set expandtab                     " use spaces, not tab characters
set nocompatible                  " don't need to be compatible with old vim
set relativenumber                " show relative line numbers
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set timeoutlen=500                " decrease timeout for 'jk' mapping
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
runtime macros/matchit.vim        " use % to jump between start/end of methods

""""""""""""""""""""""
" BEGIN WINDOWS CONFIG
""""""""""""""""""""""
behave mswin

if has("clipboard")
  " CTRL-X and SHIFT-Del are Cut
  vnoremap <C-X> "+x
  vnoremap <S-Del> "+x

  " CTRL-C and CTRL-Insert are Copy
  vnoremap <C-C> "+y
  vnoremap <C-Insert> "+y

  " CTRL-V and SHIFT-Insert are Paste
  map <C-V> "+gP
  map <S-Insert> "+gP

  cmap <C-V> <C-R>+
  cmap <S-Insert> <C-R>+
endif

if 1
  exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
  exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
endif
""""""""""""""""""""""
" END WINDOWS CONFIG
""""""""""""""""""""""

" put git status, column/row number, total lines, and percentage in status
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

" setup color scheme
set background=dark
colorscheme gruvbox

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" set leader key to comma
let mapleader = ","

" ctrlp config
let g:ctrlp_map = '<leader>f'
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
nmap <leader>F :CtrlPClearCache<cr>

" NERDTree config
nmap <leader>g :NERDTreeToggle<cr>

" fugitive config
let g:github_enterprise_urls = ['https://github.cbhq.net']

" use silver searcher for ctrlp
let g:ctrlp_user_command = 'ag %s -l -g ""'

" vimwiki configuration
let g:vimwiki_list = [{'path': '~/Dropbox/notes', 'path_html': '~/Dropbox/notes/html', 'ext': '.md', 'auto_export': 0, 'syntax': 'markdown'}]

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" map test runner
nmap <silent> <leader>t :TestFile<cr>
nmap <silent> <leader>T :TestNearest<cr>

" map jk to escape (thanks touchbar)
inoremap jk <Esc>
inoremap kj <Esc>

" map escape to exit terminal insert mode
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

" unmap ex mode: 'Type visual to go into Normal mode.'
nnoremap Q <nop>

" map . in visual mode
vnoremap . :norm.<cr>

" map markdown preview
nmap <leader>m :!open -a "Marked 2" "%"<cr><cr>

" map git commands
nmap <leader>b :Gblame<cr>
nmap <leader>l :split \| terminal git log -p %<cr>
nmap <leader>d :split \| terminal git diff %<cr>

" map Silver Searcher
nmap <leader>a :Ag!<space>

" clear the command line and search highlighting
noremap <C-l> :nohlsearch<CR>

" toggle spell check with `
nmap ` :setlocal spell! spelllang=en_us<cr>

" add :Plain command for converting text to plaintext
command! Plain execute "%s/[’‘]/'/ge | %s/[“”]/\"/ge | %s/—/-/ge | %s/–/-/ge"

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
endif

" jump to last position in file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" multi-purpose tab key (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
nmap <leader>n :call RenameFile()<cr>

" vim-test extensions
function! ElixirUmbrellaTransform(cmd) abort
  if match(a:cmd, 'apps/') != -1
    " return substitute(a:cmd, 'mix test apps/\([^/]*/\)', 'cd apps/\1 \&\& mix test ', '')
    return substitute(a:cmd, 'mix test apps/\([^/]*/\)', 'mix test ', '')
  else
    return a:cmd
  end
endfunction

let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
let g:test#transformation = 'elixir_umbrella'
let g:test#preserve_screen = 0
