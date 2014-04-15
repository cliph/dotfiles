set tabstop=3
set sw=3
set smartindent
set smarttab
set autoindent
set printoptions=paper:letter
set hlsearch    " highlight search results
set linebreak   " linebreak on words rather than absolute line lengths
set incsearch   " search incrementally
set expandtab
set modeline   " will automatically scan files for magic comments
set nowrap
syntax on
set ai


set ls=2
set number
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P


filetype plugin indent on

