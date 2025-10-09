return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl="ErrorMsg" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl="ErrorMsg" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl="ErrorMsg" })
            vim.fn.sign_define("DapLogPoint", { text = "L", texthl="ErrorMsg" })
            vim.fn.sign_define("DapStopped", { text = "⮕", texthl="WarningMsg" })

            -- C# Debugger setup
            local netcorebg_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"

            local netcoredbg_adapter = {
                type = "executable",
                command = netcorebg_path,
                args = { "--interpreter=vscode" },
            }

            dap.adapters.coreclr = netcoredbg_adapter
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "Launch",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to dll: ", vim.fn.getcwd(), "file")
                    end,
                },
                {
                    type = "coreclr",
                    name = "Attach",
                    request = "attach",
                    processId = require("dap.utils").pick_process,
                }
            }

            vim.keymap.set('n', "<leader>db", dap.toggle_breakpoint)
            vim.keymap.set('n', "<leader>dc", dap.continue)
            vim.keymap.set('n', "<leader>di", dap.step_into)
            vim.keymap.set('n', "<leader>do", dap.step_over)
        end

    },
    {
        "igorlfs/nvim-dap-view",
        config = function()
            local dap = require("dap")
            local dap_view = require("dap-view")

            dap.listeners.after.event_initialized["dapui_config"] = function() dap_view.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dap_view.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dap_view.close() end

            dap_view.setup()
        end
    }
}
