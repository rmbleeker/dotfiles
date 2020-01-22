set fileformat=unix
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab autoindent
set laststatus=2 statusline=%F title
set number ruler
set list listchars=eol:«,tab:»·,nbsp:·,trail:·,extends:►,precedes:◄

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml " foldmethod=indent
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

