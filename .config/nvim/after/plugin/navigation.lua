local fzf = require("fzf-lua")

fzf.setup()
fzf.register_ui_select()

vim.keymap.set('n', "<leader>fg", fzf.git_files)
vim.keymap.set('n', "<leader>ft", fzf.blines)
vim.keymap.set('n', "<leader>ff", fzf.files)
vim.keymap.set('n', "<leader>fr", fzf.resume)
vim.keymap.set('n', "<leader>fl", fzf.live_grep)
vim.keymap.set("n", "<leader>bb", fzf.buffers)

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
