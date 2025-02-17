--
--  Made by Norbert Horvath (norbert204)
--

local fn = vim.fn
local g = vim.g
local opt = vim.opt
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

local map_options = { noremap = true, silent = true }

--
--  Quality of life improving keybindings
--

local keymaps = {
    --  Reload nvim config with a press of a button (Broken with Lazy)
    -- { 'n', '<F11>', ":luafile ~/.config/nvim/init.lua<CR>:echo 'Config reloaded!'<CR>" },

    --  Use JK keycombo instead of ESC to exit insert mode
    { 'i', 'jk', "<esc>" },

    --  An easier way to switch between splits
    --  (Done by vim-tmux plugin)
    -- { 'n', '<C-h>', "<C-w>h" },
    -- { 'n', '<C-j>', "<C-w>j" },
    -- { 'n', '<C-k>', "<C-w>k" },
    -- { 'n', '<C-l>', "<C-w>l" },

    --  Jump to the start or to the end of the line
    { 'i', '<C-A>', "<esc>A" },
    { 'i', '<C-E>', "<esc>I" },

    --  When wrap is enabled, navigating the wraped lines is a pain by default
    { 'n', 'j', "gj" },
    { 'n', 'k', "gk" },

    --  Center after jumps
    { {'n', 'v'}, "<C-f>", "<C-f>zz" },
    { {'n', 'v'}, "<C-b>", "<C-b>zz" },
    { {'n', 'v'}, "<C-d>", "<C-d>zz" },
    { {'n', 'v'}, "<C-u>", "<C-u>zz" },

    --  Search for the highlighted text
    { 'v', '/', "y/<C-r><C-0><return><esc>" },

    --  Escape from insert mode in terminal with the same keychord as from regular insert mode
    { 't', "jk", "<C-\\><C-n>" },

    --  Hungarian keyboard shenanigans
    { '', 'é', '$' },

    -- Thanks Primeagen
    { 'v', "J", ":m '>+1<CR>gv=gv" },
    { 'v', "K", ":m '<-2<CR>gv=gv" },

    -- 
    { 'n', "<leader>n", cmd.Ex },

    -- Buffers
    { 'n', "<leader>bp", "<cmd>bprevious<cr>" },
    { 'n', "<leader>bn", "<cmd>bnext<cr>" },
    { 'n', "<C-S-P>", "<cmd>bprevious<cr>" },
    { 'n', "<C-S-N>", "<cmd>bnext<cr>" },
    { 'n', "<C-P>", "<cmd>bprevious<cr>" },
    { 'n', "<C-N>", "<cmd>bnext<cr>" },

    -- Split resizing
    { 'n', "<M-h>", "<C-w>5<" },
    { 'n', "<M-l>", "<C-w>5>" },
    { 'n', "<M-k>", "<C-w>+" },
    { 'n', "<M-j>", "<C-w>-" },
}

local function register_keymaps()
    -- Register the keymaps all at once (might be a bit overkill)
    for _, v in ipairs(keymaps) do
        if #v == 4 then
            vim.keymap.set(v[1], v[2], v[3], v[4])
        else
            vim.keymap.set(v[1], v[2], v[3], map_options)
        end
    end
end

local function append_keymaps(maps)
    for _,v in ipairs(maps) do
        table.insert(keymaps, v)
    end
end

if vim.loop.os_uname().sysname == "Linux" or vim.loop.os_uname().sysname == "Darwin" then
    table.insert(keymaps, { 'n', "<F12>", ":e ~/.config/nvim/init.lua<cr>", map_options })
end

--  Space as leader
g.mapleader = " "
g.maplocalleader = " "

local theme = "gruvbox"

--
--  Plugins
--

require("lazy").setup({
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup { }
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = true
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
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
        tag = '0.1.6',
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

            append_keymaps({
                { 'n', "<leader>ft", telescope_builtin.current_buffer_fuzzy_find },
                { 'n', "<leader>ff", telescope_builtin.find_files },
                { 'n', "<leader>fg", telescope_builtin.git_files },

                -- Telescope git
                { 'n', "<leader>gb", telescope_builtin.git_branches },
                { 'n', "<leader>gs", telescope_builtin.git_status },

                -- Buffers
                { 'n', "<leader>bb", telescope_builtin.buffers },
            })
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

            table.insert(keymaps, { 'n', "<leader>gp", gitsigns.preview_hunk, map_options })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "lvimuser/lsp-inlayhints.nvim",
        },
        config = function()
            local inlay_hints = require("lsp-inlayhints")
            inlay_hints.setup()

            local telescope_builtin = require('telescope.builtin')

            append_keymaps({
                { 'n', '<leader>e', vim.diagnostic.open_float },
                { 'n', '[d', vim.diagnostic.goto_prev },
                { 'n', 'ő', vim.diagnostic.goto_prev },
                { 'n', ']d', vim.diagnostic.goto_next },
                { 'n', 'ú', vim.diagnostic.goto_next },
                { 'n', '<leader>q', vim.diagnostic.setloclist },
            })

            api.nvim_create_autocmd('LspAttach', {
                group = api.nvim_create_augroup('UserLspConfig', {}),

                callback = function(args)
                    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = args.buf }

                    -- Need to rethink this
                    vim.keymap.set('n', 'gD', lsp.buf.declaration, opts)
                    vim.keymap.set('n', '<leader>lk', lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>lh', lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(lsp.buf.list_workspace_folders())) end, opts)
                    vim.keymap.set('n', '<leader>ld', lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>r', lsp.buf.rename, opts)
                    vim.keymap.set({'n', 'v'}, '<leader><return>', lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>lf', function() lsp.buf.format { async = true } end, opts)
                    vim.keymap.set('n', "gd", telescope_builtin.lsp_definitions, opts)
                    vim.keymap.set('n', "gi", telescope_builtin.lsp_implementations, opts)
                    vim.keymap.set('n', "gr", telescope_builtin.lsp_references, opts)

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
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",

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
            "jlcrochet/vim-razor",
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
                    "omnisharp",
                    "matlab_ls",
                    "cssls",
                    "html",
                    "emmet_ls",
                }
            }

            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,

                -- Custom handlers
                ["omnisharp"] = function()
                    require("lspconfig")["omnisharp"].setup{
                        capabilities = capabilities,
                        filetypes = { "cs", "cshtml", "razor" },
                    }
                end,

                ["matlab_ls"] = function()
                    require("lspconfig")["matlab_ls"].setup {
                        filetypes = {"matlab"},
                        settings = {
                            matlab = {
                                installPath = "/usr/local/MATLAB/R2023b/bin/matlab",
                            }
                        },
                        single_file_support = true,
                    }
                end
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
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
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

            append_keymaps({
                { 'n', "<leader>b0", "<Cmd>BufferGoto 1<CR>" },
                { 'n', "<leader>b1", "<Cmd>BufferGoto 2<CR>" },
                { 'n', "<leader>b2", "<Cmd>BufferGoto 3<CR>" },
                { 'n', "<leader>b3", "<Cmd>BufferGoto 4<CR>" },
                { 'n', "<leader>b4", "<Cmd>BufferGoto 5<CR>" },
                { 'n', "<leader>b5", "<Cmd>BufferGoto 6<CR>" },
                { 'n', "<leader>b6", "<Cmd>BufferGoto 7<CR>" },
                { 'n', "<leader>b7", "<Cmd>BufferGoto 8<CR>" },
                { 'n', "<leader>b8", "<Cmd>BufferGoto 9<CR>" },
                { 'n', "<leader>b9", "<Cmd>BufferLast<CR>" },
                -- { 'n', "<leader>bp", "<Cmd>BufferPin<CR>" },
                { 'n', "<leader>bc", "<Cmd>BufferClose<CR>" },
                -- { 'n', "<leader>bb", "<Cmd>Telescope buffers<CR>" },
            })
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
            table.insert(keymaps, { 'n', "<leader>gg", require("neogit").open })
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup {
                css = {
                    css = true;
                    css_fn = true;
                }
            }
        end,
    },
},
{
    install = {
        colorscheme = { theme }
    }
})

vim.o.background = "dark" -- or "light" for light mode
cmd.colorscheme "catppuccin-mocha"

register_keymaps()
