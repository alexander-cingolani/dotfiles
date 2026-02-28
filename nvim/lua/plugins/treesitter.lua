return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- This is the crucial fix
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "cpp", "java", "python", "lua", "vim", "vimdoc" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
