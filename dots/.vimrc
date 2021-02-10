if !has('gui_running') && exists('&termguicolors') && $COLORTERM ==# 'truecolor'
  set termguicolors
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

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
set background=dark
set laststatus=2
set noshowmode
set updatetime=100

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
  call dein#add('cocopon/iceberg.vim')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('airblade/vim-gitgutter')

  call dein#end()
  call dein#save_state()
endif

filetype on
filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

:silent! colorscheme iceberg
let g:lightline = {
  \ 'colorscheme': 'iceberg',
  \ }

if $TERM_PROGRAM ==# 'Alacritty'
  highlight Normal ctermbg=NONE guibg=NONE
  highlight NonText ctermbg=NONE guibg=NONE
  highlight EndOfBuffer ctermbg=NONE guibg=NONE
endif
