set fileformat=unix
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab autoindent
set laststatus=2 title
set number "relativenumber numberwidth=6
set ruler cursorline hlsearch nowrap
set list listchars=eol:«,tab:»·,nbsp:·,trail:·,extends:►,precedes:◄
set showcmd showmatch
set clipboard=unnamedplus

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline  =%6*\ %n\ %*                "buffer number
set statusline +=%5*%{&fileformat}\ %*      "file format
set statusline +=%5*(%{&fileencoding?&fileencoding:&encoding})\ %*  "file encoding
set statusline +=%3*%(%y\ %)%*              "file type
set statusline +=%4*%<%F\ %*                "full path
set statusline +=%2*%m%r%*                  "modified and read-only flag
set statusline +=%1*%{StatuslineGit()}\ %*  "show git branch
set statusline +=%1*%=%11(line:\ %3l\ /%)%* "current line
set statusline +=%2*%3(%L%)%*               "total lines
set statusline +=%1*%13(col:\ %3v\ /%)%*    "virtual column number
set statusline +=%2*%3(%c%)%*               "actual column number
set statusline +=%6*%10(0x%04B%)\ %*        "character under cursor

highlight CursorLine   cterm=NONE
highlight CursorLineNr cterm=NONE ctermbg=black ctermfg=red

highlight User1 ctermfg=red       ctermbg=black
highlight User2 ctermfg=darkred   ctermbg=black
highlight User3 ctermfg=magenta   ctermbg=black
highlight User4 ctermfg=darkgreen ctermbg=black
highlight User5 ctermfg=blue      ctermbg=black
highlight User6 ctermfg=yellow    ctermbg=black

nnoremap <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufNewFile,BufRead *.{yaml,yml} set filetype=yaml     "foldmethod=indent
autocmd BufNewFile,BufRead *.md         set filetype=markdown
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

