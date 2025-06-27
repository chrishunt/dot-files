" .vimrc
set encoding=utf-8

" Load up all our plugins with vim-plugged
call plug#begin('~/.vim/plugged')
  Plug 'ap/vim-css-color'     " highlight hex values with their color
  Plug 'godlygeek/tabular'    " align stuff... like these vim comments
  Plug 'mattn/webapi-vim'
  Plug 'morhetz/gruvbox'      " current colorscheme
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary' " comment stuff out, like these comments
  Plug 'tpope/vim-surround'   " change and add surrounds, []()
  Plug 'windwp/nvim-autopairs' " auto pair quotes, brackets, etc

  " Git integration
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'tpope/vim-fugitive' " needed for rhubarb
  Plug 'tpope/vim-rhubarb'  " git(hub) wrapper - open on GitHub

  " Status line
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-tree/nvim-web-devicons'

  " File (fuzzy) search
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}
  Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'master', 'do': 'TSUpdate'}

  " LSP configuration and plugins
  Plug 'neovim/nvim-lspconfig' " default LSP settings
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
call plug#end()

syntax on                         " show syntax highlighting
filetype plugin indent on
set autoindent                    " set auto indent
set ts=4 sw=4                     " set indent to 4 spaces
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN LUA CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
-- Mason: LSP installer UI
require("mason").setup()

-- Turn on auto-pairs
require("nvim-autopairs").setup {}

-- Status line
require'nvim-web-devicons'.setup {}
require("lualine").setup({
  options = {
    theme = 'gruvbox',
  }
})

-- nvim-cmp capabilities for better autocomplete integration
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Mason-LSPConfig: just install, don't configure
require("mason-lspconfig").setup {
  ensure_installed = { "ts_ls" },
  automatic_installation = true,  -- optional: ensure it's installed
  handlers = {
    -- Default handler for all servers
    function(server_name)
      if server_name == "ts_ls" then
        require("lspconfig")[server_name].setup {
          capabilities = capabilities,
        }
      end
    end,
  }
}

-- nvim-cmp autocompletion setup
local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      -- you can plug LuaSnip or VSCode-style snippets here
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
}

-- Set up completion for `/` and `?` (search)
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Set up completion for `:` (command line)
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Add language syntax parsers for all
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { 'ipkg' },
}

-- Keybindings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

-- Adjust diagnostics
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
})
EOF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END LUA CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN WINDOWS CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END WINDOWS CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" setup color scheme
set background=dark
colorscheme gruvbox

" set leader key to comma
let mapleader = ","

" set the size of the quick-fix window
autocmd FileType qf wincmd J | resize 10

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" NERDTree config
nmap <leader>g :NERDTreeToggle<cr>
nmap <leader>G :NERDTreeRefreshRoot<cr>

" Ale configuation
let g:ale_set_highlights=0

" Telescope.nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" if using nvim terminal, re-map normal mode
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

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
noremap <leader>b :Gitsigns blame<cr>
noremap <leader>B :Gitsigns blame_line<cr>
noremap <leader>l :split \| terminal git log -p %<cr>
noremap <leader>d :split \| terminal git diff %<cr>

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
