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

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
