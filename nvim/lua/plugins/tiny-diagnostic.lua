return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        require('tiny-inline-diagnostic').setup()

        -- Disable standard virtual text so you don't see double errors
        vim.diagnostic.config({ virtual_text = false })
    end
}
