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
set statusline +=%1*%10(col:\ %3v%)%*     "virtual column number
set statusline +=%2*%4(/%c%)%*            "actual column number
set statusline +=%6*%10(0x%04B%)\ %*      "character under cursor

hi User1 ctermfg=red       ctermbg=darkgray
hi User2 ctermfg=darkred   ctermbg=darkgray
hi User3 ctermfg=magenta   ctermbg=darkgray
hi User4 ctermfg=darkgreen ctermbg=darkgray
hi User5 ctermfg=blue      ctermbg=darkgray
hi User6 ctermfg=yellow    ctermbg=darkgray

au BufNewFile,BufRead *.{yaml,yml} set filetype=yaml     "foldmethod=indent
au BufNewFile,BufRead *.md         set filetype=markdown
au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

