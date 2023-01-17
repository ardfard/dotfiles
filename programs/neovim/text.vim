" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces, unless the file is already
" using tabs, in which case tabs will be inserted.
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

if has('unix')
  " Copy and paste to os clipboard
  nmap <leader>y "+y
  vmap <leader>y "+y
  nmap <leader>d "+d
  vmap <leader>d "+d
  nmap <leader>p "+p
  vmap <leader>p "+p
else
  nmap <leader>y "*y
  vmap <leader>y "*y
  nmap <leader>d "*d
  vmap <leader>d "*d
  nmap <leader>p "*p
  vmap <leader>p "*p
end

" }}}

