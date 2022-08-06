"
"   Made by Horváth Norbert
"   Last edited: 2022.07.30
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

"   --  New splits on the right and the bottom  --
set splitright
set splitbelow

syntax on

"   --  Insert mode keybindings --
"
"   Use jk keycombo instead of Esc to exit insert mode" 
inoremap jk <esc>
"   Jump to the end of the line
inoremap <C-A> <esc>A
"   Jump to the begining of the line
inoremap <C-E> <esc>I

"   --  Plugins --  "
call plug#begin()
    "   Colorscheme
    Plug 'sainnhe/sonokai'
    "   Statusline
    Plug 'itchyny/lightline.vim'
    "   NerdTree and addons 
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    "   Better highlighting 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    "   Code completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'} 
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

"   --  CoC config (WIP)  --
"
"   Recently vim can merge signcolumn and number column into one
if has("nvim-0.5.0") || has("patch-8.1.1564")
    set signcolumn=number
else
    "   Recently...
    set signcolumn=yes
endif

"   Using tab to jump between suggestions
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ CheckBackspace() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"   Ctrl+Space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

"   --  TreeSitter config   --
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "java" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
EOF
