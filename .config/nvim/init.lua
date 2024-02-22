--
--  Made by Norbert Horvath (norbert204)
--

local fn = vim.fn
local g = vim.g
local opt = vim.opt
local keymap = vim.keymap.set
local cmd = vim.cmd
local api = vim.api
local lsp = vim.lsp

-- Lazy
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--
--  Basic options
--

opt.encoding = "utf-8"
opt.number = true
opt.relativenumber = true

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

cmd([[let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro']])

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

if vim.loop.os_uname().sysname == "Linux" then
    keymap('n', "<F12>", ":e ~/.config/nvim/init.lua<cr>", map_options)
end

--  When wrap is enabled, navigating the wraped lines is a pain by default
keymap('n', 'j', "gj", map_options)
keymap('n', 'k', "gk", map_options)

--
--  Normal+Visual mode

--  Center after jumps
keymap({'n', 'v'}, "<C-f>", "<C-f>zz", map_options)
keymap({'n', 'v'}, "<C-b>", "<C-b>zz", map_options)
keymap({'n', 'v'}, "<C-d>", "<C-d>zz", map_options)
keymap({'n', 'v'}, "<C-u>", "<C-u>zz", map_options)

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
-- keymap('', "<Space>", "<Nop>", map_options)
g.mapleader = " "
g.maplocalleader = " "

local theme = "tokyonight-moon"

-- NetRW
--

keymap('n', "<leader>n", cmd.Ex, map_options)

--
--  Plugins
--

require("lazy").setup({
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                extensions = {
                    "nvim-tree"
                }
            }
        end
    },
    {
        "folke/tokyonight.nvim",
    },
    {
        "nvim-tree/nvim-web-devicons"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = true
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.4',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim"
        },
        config = function()
            local telescope = require('telescope')
            local telescope_builtin = require('telescope.builtin')
            local telescope_themes = require("telescope.themes")

            telescope.setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            -- ["<tab>"] = "move_selection_next",
                            -- ["<S-tab>"] = "move_selection_previous",
                        }
                    }
                },
                extensions = {
                    ["ui-select"] = {
                        telescope_themes.get_dropdown(),
                    }
                }
            }

            telescope.load_extension("ui-select")

            keymap('n', "<leader>ft", telescope_builtin.current_buffer_fuzzy_find, map_options)
            keymap('n', "<leader>ff", telescope_builtin.find_files, map_options)
            keymap('n', "<leader>fg", telescope_builtin.git_files, map_options)

            -- Telescope git
            keymap('n', "<leader>gb", telescope_builtin.git_branches, map_options)
            keymap('n', "<leader>gs", telescope_builtin.git_status, map_options)
        end
    },
    {
        "windwp/nvim-autopairs",
        config = true
    },
    --  Might replace later
    {
        "mhinz/vim-startify",
        config = function()
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
        end
    },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                execution_message = {
                    message = ""
                }
            }
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup()

            keymap('n', "<leader>gp", gitsigns.preview_hunk, map_options)
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "lvimuser/lsp-inlayhints.nvim",

            -- "hrsh7th/nvim-cmp",
            -- "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-buffer",
            -- "hrsh7th/cmp-path",
            -- "hrsh7th/cmp-cmdline",
            -- "L3MON4D3/LuaSnip",
        },
        config = function()
            local inlay_hints = require("lsp-inlayhints")
            inlay_hints.setup()

            local telescope_builtin = require('telescope.builtin')

            keymap('n', '<space>e', vim.diagnostic.open_float, map_options)
            keymap('n', '[d', vim.diagnostic.goto_prev, map_options)
            keymap('n', 'ő', vim.diagnostic.goto_prev, map_options)
            keymap('n', ']d', vim.diagnostic.goto_next, map_options)
            keymap('n', 'ú', vim.diagnostic.goto_next, map_options)
            keymap('n', '<space>q', vim.diagnostic.setloclist, map_options)

            api.nvim_create_autocmd('LspAttach', {
                group = api.nvim_create_augroup('UserLspConfig', {}),

                callback = function(args)
                    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = args.buf }

                    keymap('n', 'gD', lsp.buf.declaration, opts)
                    keymap('n', 'K', lsp.buf.hover, opts)
                    keymap('n', '<leader>k', lsp.buf.signature_help, opts)
                    keymap('n', '<leader>wa', lsp.buf.add_workspace_folder, opts)
                    keymap('n', '<leader>wr', lsp.buf.remove_workspace_folder, opts)
                    keymap('n', '<leader>wl', function()
                        print(vim.inspect(lsp.buf.list_workspace_folders()))
                    end, opts)
                    keymap('n', '<leader>D', lsp.buf.type_definition, opts)
                    keymap('n', '<leader>r', lsp.buf.rename, opts)
                    keymap({ 'n', 'v' }, '<leader><return>', lsp.buf.code_action, opts)
                    keymap('n', '<leader>F', function()
                        lsp.buf.format { async = true }
                    end, opts)
                    keymap('n', "gd", telescope_builtin.lsp_definitions, opts)
                    keymap('n', "gi", telescope_builtin.lsp_implementations, opts)
                    keymap('n', "gr", telescope_builtin.lsp_references, opts)

                    local bufnr = args.buf
                    local client = lsp.get_client_by_id(args.data.client_id)

                    inlay_hints.on_attach(client, bufnr)
                end,
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            "windwp/nvim-autopairs",
            "saecki/crates.nvim",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<tab>'] = cmp.mapping(function(fallback)
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
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    -- Extra from plugins
                    { name = "crates" },
                }),
            }

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

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            -- Language specific plugins
            "elkowar/yuck.vim",
            "Decodetalkers/csharpls-extended-lsp.nvim",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,

                -- Custom handlers
                ["csharp_ls"] = function()
                    require("lspconfig")["csharp_ls"].setup {
                        capabilities = capabilities,
                        handlers = {
                            ["textDocument/definition"] = require('csharpls_extended').handler,
                        },
                    }
                end,
            }
        end
    },
    {
        "saecki/crates.nvim",
        tag = "stable",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = true,
    },
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup {
                copy_sync = {
                    enable = false
                }
            }
        end,
    },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
        },
        config = function()
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
                }
            }

            keymap('n', "<leader>b0", "<Cmd>BufferGoto 1<CR>", map_options)
            keymap('n', "<leader>b1", "<Cmd>BufferGoto 2<CR>", map_options)
            keymap('n', "<leader>b2", "<Cmd>BufferGoto 3<CR>", map_options)
            keymap('n', "<leader>b3", "<Cmd>BufferGoto 4<CR>", map_options)
            keymap('n', "<leader>b4", "<Cmd>BufferGoto 5<CR>", map_options)
            keymap('n', "<leader>b5", "<Cmd>BufferGoto 6<CR>", map_options)
            keymap('n', "<leader>b6", "<Cmd>BufferGoto 7<CR>", map_options)
            keymap('n', "<leader>b7", "<Cmd>BufferGoto 8<CR>", map_options)
            keymap('n', "<leader>b8", "<Cmd>BufferGoto 9<CR>", map_options)
            keymap('n', "<leader>b9", "<Cmd>BufferLast<CR>", map_options)
            keymap('n', "<leader>bp", "<Cmd>BufferPin<CR>", map_options)
            keymap('n', "<leader>bc", "<Cmd>BufferClose<CR>", map_options)

            keymap('n', "<leader>bb", "<Cmd>Telescope buffers<CR>", map_options)
        end
    },
    {
        "sindrets/diffview.nvim",
        config = true
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
        },
        config = function()
            local neogit = require("neogit")

            neogit.setup {
                graph_style = "unicode",
                kind = "replace",
            }

            keymap('n', "<leader>gg", neogit.open, map_options)
        end
    },
},
{
    install = {
        colorscheme = { theme }
    }
})

cmd.colorscheme "tokyonight-moon"
