syntax enable
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

if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#end()
  call dein#save_state()
endif

filetype on
filetype plugin indent on

if dein#check_install()
  call dein#install()
endif
