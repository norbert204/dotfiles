return {
    {
        "github/copilot.vim",
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        config = function()
            local copilot_chat = require("CopilotChat")

            copilot_chat.setup {
                window = {
                    layout = "vertical"
                }
            }

            vim.keymap.set({ 'n', 'v' }, "<leader>cc", copilot_chat.open)
            vim.keymap.set({ 'n', 'v' }, "<leader>cr", copilot_chat.reset)
            vim.keymap.set({ 'n', 'v' }, "<leader>cm", copilot_chat.select_model)
        end
    },
}
