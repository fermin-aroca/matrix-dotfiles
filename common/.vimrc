" ============================================================
" Matrix Dotfiles
" ------------------------------------------------------------
" Author    : Fermin Aroca
" License   : MIT
" ============================================================

set encoding=utf-8
set fileencoding=utf-8
set number
syntax enable
filetype plugin indent on

set autoindent
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set ignorecase
set smartcase
set incsearch
set hlsearch
set showmatch
set backspace=indent,eol,start
set hidden
set ruler
set wildmenu

if has('persistent_undo')
    let s:undo_dir = expand('~/.vim/undo')
    if !isdirectory(s:undo_dir)
        call mkdir(s:undo_dir, 'p', 0700)
    endif
    let &undodir = s:undo_dir
    set undofile
endif
