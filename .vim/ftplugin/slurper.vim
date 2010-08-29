" Vim filetype plugin
" Language:	Slurper
" Maintainer:	Adam Lowe <contact@adamlowe.me>

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal spell
highlight SpellCap none

nmap <buffer> <C-h> 
      \o
      \<C-D>==
      \<CR><C-D>story_type:
      \<CR><C-T>chore
      \<CR><C-D>name:
      \<CR>  
      \<CR><C-D>description:
      \<CR>  
      \<CR>
      \<CR><C-D>labels:
      \<CR>  
      \<Esc>
      \5
      \k
      \<S-a>

imap <buffer> <C-j> <C-O><C-j>

nmap <buffer> <C-j> 
      \o
      \<C-D>==
      \<CR><C-D>story_type:
      \<CR><C-T>feature
      \<CR><C-D>name:
      \<CR>  
      \<CR><C-D>description:
      \<CR><C-T>In order to
      \<CR>As a
      \<CR>I want
      \<CR>
      \<CR>-
      \<CR>
      \<CR><C-D>labels:
      \<CR>  
      \<Esc>
      \9
      \k
      \<S-a>

imap <buffer> <C-j> <C-O><C-j>

nmap <buffer> <C-k> 
      \o
      \<C-D>==
      \<CR><C-D>story_type:
      \<CR><C-T>release
      \<CR><C-D>name:
      \<CR>  
      \<CR><C-D>description:
      \<CR>  
      \<CR>
      \<CR><C-D>labels:
      \<CR>  
      \<Esc>
      \5
      \k
      \<S-a>

imap <buffer> <C-k> <C-O><C-k>

nmap <buffer> <C-l> 
      \o
      \<C-D>==
      \<CR><C-D>story_type:
      \<CR><C-T>bug
      \<CR><C-D>name:
      \<CR>  
      \<CR><C-D>description:
      \<CR>  
      \<CR>
      \<CR><C-D>labels:
      \<CR>  
      \<Esc>
      \5
      \k
      \<S-a>

imap <buffer> <C-l> <C-O><C-l>
