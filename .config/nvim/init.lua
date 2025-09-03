--
-- Made by Norbert Horváth (norbet204)
--

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "160"
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.laststatus = 3
vim.opt.listchars = {
    trail = ".",
    tab = "→ ",
}
vim.opt.list = true
vim.opt.fixendofline = false
vim.opt.scrolloff = 4
vim.opt.termguicolors = true
-- vim.opt.autocomplete = true
-- vim.opt.complete = "o,.,w"
-- vim.opt.completeopt = "fuzzy"

vim.g.mapleader = " "
vim.g.netrw_bufsettings = "noma nomod nu relativenumber nobl nowrap ro"
vim.g.netrw_banner = 0

vim.keymap.set('i', "jk", "<esc>")
vim.keymap.set('n', "<f12>", "<cmd>e ~/.config/nvim/init.lua<cr>")
vim.keymap.set('n', "<f11>", function()
    vim.cmd("source")
    print("Sourced file")
end)
vim.keymap.set('n', "<leader>n", "<cmd>Ex<cr>")
vim.keymap.set({ 'n', 'v', 'x' }, "<A-p>", "\"+p")
vim.keymap.set({ 'n', 'v', 'x' }, "<A-y>", "\"+y")
vim.keymap.set('n', "<C-[>", "<cmd>bprev<cr>")
vim.keymap.set('n', "<C-]>", "<cmd>bnext<cr>")
vim.keymap.set('n', "<leader>bc", "<cmd>bdelete!|bprev<cr>")

-- Lua?
-- vim.keymap.set('i', "<tab>", [[ pumvisible() ? "\<C-n>" : "\<tab>" ]], { expr = true })
-- vim.keymap.set('i', "<S-tab>", [[ pumvisible() ? "\<C-p>" : "\<S-tab>" ]], { expr = true })
-- vim.keymap.set('i', "<cr>", [[ pumvisible() ? \"<C-y>" : \"<cr>" ]], { expr = true }) -- Didn't work

vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catpuccin" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" }, -- vim.pack doesn't support wildcard versions
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },

    -- Not mandatory
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/prichrd/netrw.nvim" },
})

-- Not working I think
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        if args.data.kind == "update" then
            vim.cmd("TSUpdate")
        end
    end
})

vim.cmd("colorscheme catppuccin-mocha")

local telescope = require("telescope")
local telescope_themes = require("telescope.themes")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
        },
    },
    extensions = {
        ["ui-select"] = {
            telescope_themes.get_dropdown(),
        }
    }
}

telescope.load_extension("ui-select")

local telescope_builtin = require("telescope.builtin")
vim.keymap.set('n', "<leader>ff", telescope_builtin.find_files)
vim.keymap.set('n', "<leader>ft", telescope_builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', "<leader>fg", telescope_builtin.git_files)
vim.keymap.set('n', "<leader>fl", telescope_builtin.live_grep)
vim.keymap.set('n', "<leader>fr", telescope_builtin.resume)
vim.keymap.set('n', "<leader>bb", telescope_builtin.buffers)

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
    },
}

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
            runtime = {
                version = 'LuaJIT'
            },
            telemetry = { enable = false },
            diagnostics = {
                globals = { "vim" },
            },
        }
    },
})

require("blink.cmp").setup {
    completion = {
        documentation = {
            auto_show = true
        },
        list = {
            selection = {
                preselect = false,
                auto_insert = true,
            }
        }
    },
    signature = { enabled = true },
    keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        -- TODO: snippet support
        ['<CR>'] = { 'accept', 'fallback' },
        ["<Tab>"] = { 'select_next', 'fallback' },
        ["<S-tab>"] = { 'select_prev', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    }
}

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
            -- Auto install TreeSitter parsers if available
            local treesitter = require("nvim-treesitter")
            local filetype = vim.bo[args.buf].filetype

            if vim.tbl_contains(treesitter.get_available(), filetype) then
                treesitter.install(filetype)
                -- TODO: Autostart treesitter once we have a callback after the async install
            end
        end
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        vim.diagnostic.config({ virtual_text = true })

        -- Register keymaps for current buffer
        local keymap_opts = { buffer = args.buf }

        vim.keymap.set('n', "<leader>lk", vim.lsp.buf.hover, keymap_opts)
        vim.keymap.set('n', "<leader>lr", vim.lsp.buf.rename, keymap_opts)
        vim.keymap.set('n', "<leader><return>", vim.lsp.buf.code_action, keymap_opts)
        vim.keymap.set('n', "<leader>lf", vim.lsp.buf.format, keymap_opts)
        vim.keymap.set('n', "<leader>le", vim.diagnostic.open_float, keymap_opts)

        vim.keymap.set('n', "gd", telescope_builtin.lsp_definitions, keymap_opts)
        vim.keymap.set('n', "gi", telescope_builtin.lsp_implementations, keymap_opts)
        vim.keymap.set('n', "gr", telescope_builtin.lsp_references, keymap_opts)
        vim.keymap.set('n', "gD", telescope_builtin.lsp_type_definitions, keymap_opts)
    end
})

vim.keymap.set('n', "<leader>gg", "<cmd>Neogit<cr>")

require("diffview").setup {
    hooks = {
        diff_buf_win_enter = function()
            vim.opt_local.foldenable = false
            vim.opt_local.fillchars = "diff: "
        end,
    },
    keymaps = {
        view = {
            [ "<C-j>" ] = "]c",
            [ "<C-k>" ] = "[c",
            [ "q" ] = "<cmd>DiffviewClose<cr>",
        },
        file_panel = {
            [ "q" ] = "<cmd>DiffviewClose<cr>",
        }
    },
}

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Not mandatory

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons() -- Insanely cool

require('lualine').setup()

require("netrw").setup()

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.opt_local.statuscolumn = "%l %s"
    end
})
