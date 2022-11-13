--
--  Made by Norbert Horvath (norbert204)
--  Last edit: 2022.11.13
--

local fn = vim.fn
local g = vim.g
local opt = vim.opt
local keymap = vim.keymap.set
local cmd = vim.cmd
local api = vim.api

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

        --  Icons
        use 'kyazdani42/nvim-web-devicons'

        --  Statusline
        use 'nvim-lualine/lualine.nvim'

        --  File manager
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
            }
        }

        --  Better highlighting
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        }

        --  Telescope
        use {
            'nvim-telescope/telescope.nvim', 
            tag = '0.1.0',
            requires = { 
              {'nvim-lua/plenary.nvim'} 
            }
        }

        --  CoC
        --[[use {
            'neoclide/coc.nvim',
            branch = 'master',
            run = 'yarn install --frozen-lockfile'
        }]]

        --  AutoPairs
        use "windwp/nvim-autopairs"
        

        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path' 
        use 'hrsh7th/cmp-cmdline'
        use 'L3MON4D3/LuaSnip'

        -- Language specific plugins
        use "elkowar/yuck.vim"
        use "Decodetalkers/csharpls-extended-lsp.nvim" 

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
opt.scrolloff = 7
opt.swapfile = false
opt.laststatus = 3

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

--  Quickly open this config file
if vim.loop.os_uname().sysname == "Linux" then
    keymap('n', "<F12>", ":e ~/.config/nvim/init.lua<cr>", map_options)
end

--  When wrap is enabled, navigating the wraped lines is a pain by default
keymap('n', 'j', "gj", map_options)
keymap('n', 'k', "gk", map_options)

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

if vim.loop.os_uname().sysname == "Windows_NT" then
    opt.shell = "powershell"
else
    opt.shell = "/usr/bin/fish"
end
keymap('t', "jk", "<C-\\><C-n>", map_options)
keymap('n', 'T', ":split<bar>term<cr><c-w>J:resize10<cr>", map_options)

--
--  Plugin configs
--

--  CoC config
--

--[[cmd [[
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

--  Statusline
--

require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = {
            left = '|',
            right = '|',
        },
        section_separators = {
            left = "",
            right = "",
        },
    },
    extensions = {
        "neo-tree",
    },
    -- tabline = {
    --     lualine_a = { 
    --         { 
    --             "tabs",
    --             mode = 1,
    --         } },
    --     lualine_b = {},
    --     lualine_c = {},
    --     lualine_x = {},
    --     lualine_y = {},
    --     lualine_z = {}
    -- },
}


--  TreeSitter config
--

require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "java", "lua", "python" },
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
        container = {
            enable_character_fade = false,
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "",-- this can only be used in the git_status source
                renamed   = "r",-- this can only be used in the git_status source
                -- Status type
                untracked = "?",
                ignored   = ".",
                unstaged  = "",
                staged    = "+",
                conflict  = "c",
            }    
        },
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
        winbar = true,
        statusline = false
    },
    window = {
        width = 30
    }
})

keymap('n', '<C-t>', ":Neotree toggle<cr>", map_options)
keymap('n', '<C-n>', ":Neotree focus<cr>", map_options)

--  Autosave plugin
--

require("auto-save").setup {
    execution_message = {
        message = ""
    }
}

--  Telescope
--
require('telescope').setup()

--  AutoPairs
--

require("nvim-autopairs").setup {

}

--  
--  LSP
--

--  cmp
--
local cmp = require("cmp")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert ({
        ['<tab>']  = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end 
            end),
        ['<S-tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
}

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
  
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--  LSP itself
--

keymap('n', "<leader>e", vim.diagnostic.open_float, map_options)
keymap('n', "ő", vim.diagnostic.goto_prev, map_options)     --  Since I'm using a Hungarian keyboard layout, it's easier for me to use these characters
keymap('n', "[", vim.diagnostic.goto_prev, map_options)     --  But I do put these in as well as an option
keymap('n', "ú", vim.diagnostic.goto_next, map_options)
keymap('n', "]", vim.diagnostic.goto_next, map_options)

local on_attach = function(client, bufnr)
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    
    keymap('n', "K", vim.lsp.buf.hover, bufopts)
    --keymap('n', "<C-K>", vim.lsp.buf.signature_help, bufopts)
    keymap('n', "gD", vim.lsp.buf.declaration, bufopts)
    keymap('n', "gd", vim.lsp.buf.definition, bufopts)
    keymap('n', "gi", vim.lsp.buf.implementation, bufopts)
    keymap('n', "gr", vim.lsp.buf.references, bufopts)
    keymap('n', "<leader>r", vim.lsp.buf.rename, bufopts)
    keymap('n', "<leader><return>", vim.lsp.buf.code_action, bufopts)
end

--  Language servers
--

--  Python
require('lspconfig')["pyright"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

--  Java
require('lspconfig')["jdtls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

--  C
require('lspconfig')["clangd"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

--  C#
require('lspconfig')["csharp_ls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = {
        ["textDocument/definition"] = require('csharpls_extended').handler,
    },
    --cmd = { "csharpls" },
}

--  R 
require('lspconfig')["r_language_server"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}
