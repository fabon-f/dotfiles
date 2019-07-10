syntax on
set wrapscan
set ruler
set title
set cursorline
set number
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set backspace=start,eol,indent

if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif
