set nocompatible

"  Neobundler set-up and plugin loading --{{{
set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'mattn/emmet-vim'
" }}}

" Basic settings -{{{
let mapleader=","

colorscheme solarized
set background=dark

syntax on

filetype plugin indent on

set number numberwidth=4 nowrap shiftround ruler visualbell wildmenu
set noerrorbells tabstop=4 expandtab autoindent laststatus=2 shortmess=at
set shiftwidth=4 softtabstop=4 smarttab
" }}}

" Mappings ---{{{
inoremap jk <esc>
inoremap <esc> <nop>

inoremap <leader>u <esc>viwUei
nnoremap <leader>u viwUw

nnoremap <leader>d dd

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" }}}

" Vimscript file settings ---------------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldlevelstart=0
augroup END
" }}}

augroup filetype_text
    autocmd!
    autocmd FileType text,markdown setlocal wrap
augroup END

NeoBundleCheck
