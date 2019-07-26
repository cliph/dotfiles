set laststatus=2
set tabstop=3
set sw=3
set smartindent
set smarttab
set autoindent
set printoptions=paper:letter

set showmatch   " hilight matching braces
set hlsearch    " highlight search results
set linebreak   " linebreak on words rather than absolute line lengths
set incsearch   " search incrementally
set expandtab
set modeline   " will automatically scan files for magic comments
set nowrap
" set so=10
syntax on
set ai


set ls=2
set number
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=
hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e

filetype plugin indent on

