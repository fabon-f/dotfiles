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
set hlsearch
set incsearch
set wildmenu

if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if $DEIN_GITHUB_TOKEN != ""
  let g:dein#install_github_api_token = $DEIN_GITHUB_TOKEN
endif

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('cocopon/iceberg.vim')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('kana/vim-operator-user')
  call dein#add('rhysd/vim-operator-surround', { 'depends' : 'vim-operator-user' })
  if executable("fzf")
    call dein#add('junegunn/fzf', { 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  endif

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

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
