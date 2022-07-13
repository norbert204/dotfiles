"   Made by Horváth Norbert
"   Last edited: 2022.07.13
"
"   --  Some basic settings     --  "
set encoding=utf-8
set number
set nowrap
set autoindent
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
set mouse=a
set clipboard=unnamedplus
set cursorline

syntax on

"   --  Use jk keycombo instead of Esc to exit insert mode  --  " 
inoremap jk <esc>

"   --  Plugins --  "
call plug#begin()
    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"   --  Lightline status bar  --  "
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'sonokai',
    \ }

"   --  Set colorscheme --  "
if(has("termguicolors"))
    set termguicolors
    colorscheme sonokai
endif

"   --  NERDTree config --  "
"   Keybindings     "
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"   Exit Vim if NERDTree is the only window remaining in the only tab.  "
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"   Close the tab if NERDTree is the only window remaining in it.       "
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"   If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.   "
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
