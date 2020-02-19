set fileformat=unix
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab autoindent
set laststatus=2 title
set number ruler
set list listchars=eol:«,tab:»·,nbsp:·,trail:·,extends:►,precedes:◄

set statusline  =%1*\ %n\ %*              "buffer number
set statusline +=%5*%{&ff}\ %*            "file format
set statusline +=%3*%(%y\ %)%*            "file type
set statusline +=%4*%<%F\ %*              "full path
set statusline +=%2*%m%r%*                "modified and read-only flag
set statusline +=%1*%=%10(line:\ %3l%)%*  "current line
set statusline +=%2*%4(/%L%)%*            "total lines
set statusline +=%1*%10(col:\ %3v%)\ %*   "virtual column number
set statusline +=%6*%8(0x%04B%)\ %*       "character under cursor

hi User1 ctermfg=red       ctermbg=darkgrey
hi User2 ctermfg=darkred   ctermbg=darkgrey
hi User3 ctermfg=magenta   ctermbg=darkgrey
hi User4 ctermfg=darkgreen ctermbg=darkgrey
hi User5 ctermfg=blue      ctermbg=darkgrey
hi User6 ctermfg=yellow    ctermbg=darkgrey

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml " foldmethod=indent
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

