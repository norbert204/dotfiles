set encoding=utf-8
set number
set visualbell
set t_vb=

syntax on

inoremap jk <esc>

set nowrap
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4

colorscheme cobalt

"   --  Initialize plugins  --"
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vifm/vifm.vim'
call plug#end()

"   --  Coc setup   --"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"   --  Change cursor type in different modes   --  "
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q" 

"   --  Initialize powerline statusbar  --  "
let g:powerline_pycmd="py3"
set laststatus=2
