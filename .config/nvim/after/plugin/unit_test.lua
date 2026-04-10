local neotest = require("neotest")

neotest.setup({
    adapters = {
        require("neotest-dotnet")({
            dap = {
                args = { justMyCode = false },
                adapter_name = "coreclr",
            }
        })
    }
})

vim.keymap.set("n", "<leader>tr", neotest.run.run)
vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end)
vim.keymap.set("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end)
vim.keymap.set("n", "<leader>tk", function() neotest.run.stop() end)

vim.keymap.set("n", "<leader>to", function() neotest.output_panel.toggle() end)
vim.keymap.set("n", "<leader>tc", function() neotest.output_panel.clear() end)
