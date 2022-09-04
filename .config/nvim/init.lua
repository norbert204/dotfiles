--
--  Made by Norbert Horvath (norbert204)
--  Last edit: 2022.09.04
--

local fn = vim.fn
local g = vim.g
local opt = vim.opt
local keymap = vim.keymap.set
local cmd = vim.cmd

--
--  Plugins
--

--  Bootstrapping
--  https://github.com/wbthomason/packer.nvim#bootstrapping
--
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

--  Loading plugins
--
cmd [[ packadd packer.nvim ]]

local function load_plugins()
    return require("packer").startup(function(use)
        --  Make packer manage itself
        use 'wbthomason/packer.nvim'

        --  Colorscheme
        use 'sainnhe/sonokai'

        --  Statusline
        use 'itchyny/lightline.vim'

        --  File manager
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            }
        }

        --  Better highlighting
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        }

        --  Intellisense
        use {
            'neoclide/coc.nvim',
            branch = 'master',
            run = 'yarn install --frozen-lockfile'
        }

        --  Autosave (might remove this, because we can replicate it with autocmds)
        use 'Pocco81/auto-save.nvim'
    end)
end

load_plugins()

--
--  Basic options
--

opt.encoding = "utf-8"
opt.number = true

--  New splits in the correct place
--
opt.splitright = true
opt.splitbelow = true

--  Indentation and tabs
--
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

--  Other
--
opt.mouse = 'a'
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.wrap = false
opt.signcolumn = "number"

if fn.has("termguicolors") then
    opt.termguicolors = true
end

cmd [[ colorscheme sonokai ]]

--
--  Keymaps
--

local map_options = { noremap = true, silent = true }

--
--  Insert mode

--  Use JK keycombo instead of ESC to exit insert mode
keymap('i', 'jk', "<esc>", map_options)

--  Jump to the start or to the end of the line
keymap('i', '<C-A>', "<esc>A", map_options)
keymap('i', '<C-E>', "<esc>I", map_options)

--
--  Normal mode

--  An easier way to switch between splits
keymap('n', '<C-h>', "<C-w>h", map_options)
keymap('n', '<C-j>', "<C-w>j", map_options)
keymap('n', '<C-k>', "<C-w>k", map_options)
keymap('n', '<C-l>', "<C-w>l", map_options)

--
--  Visual mode

--  Search for the highlighted text
keymap('v', '/', "y/<C-r><C-0><return><esc>", map_options)

--
--  General

keymap('', 'é', '$', map_options)

--  Space as leader
keymap('', "<Space>", "<Nop>", map_options)
g.mapleader = " "
g.maplocalleader = " "


--
--  Terminal
--
if fn.has("linux") then
    opt.shell = "/usr/bin/fish"
end
keymap('t', "<esc>", "<C-\\><C-n>", map_options)

cmd [[ nnoremap T :split<bar>term<cr><c-w>J:resize10<cr> ]]


--
--  Plugin configs
--

--  CoC config
--

cmd [[
    "   Jump between suggestions
    inoremap <silent><expr> <tab> 
        \ coc#pum#visible() ? coc#pum#next(1) : "\<tab>"
    inoremap <expr> <S-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-tab>"

    "   cancel or confirm completion
    inoremap <silent><expr> <return> coc#pum#visible() ? coc#pum#confirm() : "\<return>"

    "   Jump between diagnostics
    nmap <silent> ő <Plug>(coc-diagnostic-prev)
    nmap <silent> ú <Plug>(coc-diagnostic-next)

    "   GoTo navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gD <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    "   Show all diagnostics
    nnoremap <silent><nowait> gn :<C-u>CocList diagnostics<cr>
]]

--  Lightline
--
cmd [[
    let g:lightline = {
        \ 'colorscheme': 'sonokai',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ },
        \ }
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
]]


--  TreeSitter config
--

require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "java", "lua" },
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

--  NeoTree
--

require("neo-tree").setup({
    close_if_last_window = true,
    default_component_configs = {
        icon = {
            folder_empty = '',
            default = ''
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
    },
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = true,
    source_selector = {
        winbar = false,
        statusline = true
    },
    window = {
        width = 30
    }
})

cmd [[
    nnoremap <C-t> :Neotree toggle<cr> 
    nnoremap <C-n> :Neotree focus<cr>
]]

--  Autosave plugin
--

require("auto-save").setup {
    -- your config goes here
    -- or just leave it empty :)
}
