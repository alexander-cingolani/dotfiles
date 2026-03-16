return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Setup Mason DAP integration
        require("mason-nvim-dap").setup({
            ensure_installed = {
                "python",       -- debugpy
                "codelldb",     -- C/C++/Rust
                "javadbg",      -- java-debug-adapter
                "javatest",     -- java-test
            },
            handlers = {}, -- use default handlers for most setups
        })

        -- Configure Python debugger
        -- Mason installs debugpy to a specific path
        local mason_path = vim.fn.stdpath("data") .. "/mason/"
        local python_path = mason_path .. "packages/debugpy/venv/bin/python"
        require("dap-python").setup(python_path)

        -- Configure C/C++ (codelldb) debugger
        local codelldb_path = mason_path .. "packages/codelldb/extension/adapter/codelldb"
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = codelldb_path,
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
        -- Copy C++ config to C
        dap.configurations.c = dap.configurations.cpp

        -- Setup DAP UI
        dapui.setup()

        -- Automatically open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Keybinds
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Conditional Breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue / Start" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
        vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Debug: Toggle REPL" })
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
    end,
}
