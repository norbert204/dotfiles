--
--  Made by Norbert Horvath (norbert204)
--  Last edit: 2023.10.28
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
        use "folke/tokyonight.nvim"

        --  Icons
        use 'nvim-tree/nvim-web-devicons'

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
            run = function()
                require('nvim-treesitter.install').update({ with_sync = true })
            end,
        }

        --  Telescope
        use {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.0',
            requires = {
                {'nvim-lua/plenary.nvim'}
            }
        }

        --  Plugins for Telescope
        use "nvim-telescope/telescope-ui-select.nvim"

        --  Toggle terminal
        use {
            "akinsho/toggleterm.nvim",
            tag='*'
        }

        --  Better start screen
        use "mhinz/vim-startify"

        --  Better looking tabs
        use {
            'romgrk/barbar.nvim',
            requires = {
                'nvim-tree/nvim-web-devicons',
                'lewis6991/gitsigns.nvim',
            }
        }

        --  AutoPairs
        use "windwp/nvim-autopairs"

        --  View git diffs in vim
        use {
            'sindrets/diffview.nvim',
            requires = 'nvim-lua/plenary.nvim'
        }

        --  Magit for neovim
        use {
            'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim'
        }

        use "lewis6991/gitsigns.nvim"

        --  LSP
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'L3MON4D3/LuaSnip'

        --  LSP extra
        use 'mfussenegger/nvim-dap'
        use "williamboman/mason.nvim"
        use "williamboman/mason-lspconfig.nvim"
        --  Language specific plugins
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
opt.signcolumn = "yes"
opt.scrolloff = 7
opt.swapfile = false
opt.laststatus = 3

if fn.has("termguicolors") then
    opt.termguicolors = true
end

cmd [[ colorscheme tokyonight-moon ]]

--
--  Quality of life improving keybindings
--

local map_options = { noremap = true, silent = true }

--  Reload nvim config with a press of a button
keymap('n', '<F11>', ":luafile ~/.config/nvim/init.lua<CR>:echo 'Config reloaded!'<CR>", map_options)

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
keymap('n', '<C-y>', "<esc>ggVGy<C-o>", map_options)

--  Quickly open this config file (TODO: fix it for Windows)
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
--  Terminal mode

--  Escape from insert mode in terminal with the same keychord as from regular insert mode
keymap('t', "jk", "<C-\\><C-n>", map_options)

--
--  General

keymap('', 'é', '$', map_options)

--  Space as leader
keymap('', "<Space>", "<Nop>", map_options)
g.mapleader = " "
g.maplocalleader = " "


--
--  Integrated terminal
--

if vim.loop.os_uname().sysname == "Windows_NT" then
    opt.shell = "pwsh"
else
    opt.shell = "/usr/bin/fish"
end

--  Open a little terminal at the bottom of the screen. (Like in VSCode)
--keymap('n', 'T', ":split<bar>term<cr><c-w>J:resize10<cr>", map_options)

--
--  Plugin configs
--

--  Star screen (startify)
--

cmd [[ 
    let g:startify_custom_header = [
        \ '',
        \ '   ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
        \ '   ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
        \ '   ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
        \ '   ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
        \ '   ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
        \ '   ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
        \]
]]

--  Statusline (lualine)
--

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = {
            left = '',
            right = '',
        },
        section_separators = {
            left = "",
            right = "",
        },
    },
    extensions = {
        "neo-tree",
    },
}


--  TreeSitter config
--

require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = false,
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
                added     = "",
                modified  = "",
                deleted   = "",
                renamed   = "r",
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
        winbar = false,
        statusline = false
    },
    window = {
        width = 30,
    },
})


keymap('n', '<C-t>', ":Neotree toggle<cr>", map_options)

--  Better tabs
--

require("barbar").setup {
    auto_hide = true,
    icons = {
        button = '',
        separator = {
            left = '',
            right = '',
        },
        separator_at_end = false,
    },
    sidebar_filetypes = {
        NvimTree = true,
        ["neo-tree"] = {event = 'BufWipeout'},
    }
}

keymap('n', '<A-0>', '<Cmd>BufferGoto 1<CR>', map_options)
keymap('n', '<A-1>', '<Cmd>BufferGoto 2<CR>', map_options)
keymap('n', '<A-2>', '<Cmd>BufferGoto 3<CR>', map_options)
keymap('n', '<A-3>', '<Cmd>BufferGoto 4<CR>', map_options)
keymap('n', '<A-4>', '<Cmd>BufferGoto 5<CR>', map_options)
keymap('n', '<A-5>', '<Cmd>BufferGoto 6<CR>', map_options)
keymap('n', '<A-6>', '<Cmd>BufferGoto 7<CR>', map_options)
keymap('n', '<A-7>', '<Cmd>BufferGoto 8<CR>', map_options)
keymap('n', '<A-8>', '<Cmd>BufferGoto 9<CR>', map_options)
keymap('n', '<A-9>', '<Cmd>BufferLast<CR>', map_options)
keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', map_options)
keymap('n', '<A-c>', '<Cmd>BufferClose<CR>', map_options)

keymap('n', '<A-b>', '<Cmd>Telescope buffers<CR>', map_options)

--  Autosave plugin
--

require("auto-save").setup {
    execution_message = {
        message = ""
    }
}

--  Telescope
--

local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local telescope_themes = require("telescope.themes")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous"
            }
        }
    },
    extensions = {
        ["ui-select"] = {
            telescope_themes.get_dropdown(),
        }
    }
}

-- telescope.load_extension("ui-select")

--  ToggleTerm
--

require("toggleterm").setup {
    size = 10,
}
keymap('n', '<leader>t', ":ToggleTerm<CR>", map_options)

--  AutoPairs
--

require("nvim-autopairs").setup()

--  Cmp
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

--  LSP
--

keymap('n', "<leader>e", vim.diagnostic.open_float, map_options)
keymap('n', "ő", vim.diagnostic.goto_prev, map_options)     --  Since I'm using a Hungarian keyboard layout, it's easier for me to use these characters
keymap('n', "[", vim.diagnostic.goto_prev, map_options)     --  But I do put these in as well as an option
keymap('n', "ú", vim.diagnostic.goto_next, map_options)
keymap('n', "]", vim.diagnostic.goto_next, map_options)

local on_attach = function(client, bufnr)
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    keymap('n', "<leader>K", vim.lsp.buf.hover, bufopts)
    keymap('n', "<leader>k", vim.lsp.buf.signature_help, bufopts)
    keymap('n', "gD", vim.lsp.buf.declaration, bufopts)
    keymap('n', "gd", telescope_builtin.lsp_definitions, bufopts)
    keymap('n', "gi", telescope_builtin.lsp_implementations, bufopts)
    keymap('n', "gr", telescope_builtin.lsp_references, bufopts)
    keymap('n', "<leader>r", vim.lsp.buf.rename, bufopts)
    keymap('n', "<leader><return>", vim.lsp.buf.code_action, bufopts)
end

--  Mason
--

require("mason").setup()

require("mason-lspconfig").setup {
    automatic_installation = true,
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "clangd",
        "csharp_ls",
    }
}

require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,

    ["csharp_ls"] = function ()
        require("lspconfig")["csharp_ls"].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = {
                ["textDocument/definition"] = require('csharpls_extended').handler,
            },
        }
    end,
}

--  DiffView
--

require("diffview").setup()

--  NeoGit
--

local neogit = require("neogit")
neogit.setup {
    integrations = {
        diffview = true,
        telescope = true,
    }
}

keymap('n', "<leader>g", neogit.open, map_options)

--  GitSigns
--

require("gitsigns").setup()

--  Debugger
--

-- TODO
