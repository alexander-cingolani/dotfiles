return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Requires a Nerd Font for icons
      "MunifTanjim/nui.nvim",
    },
    config = function()
        -- Toggle the file explorer with <leader>e
        vim.keymap.set('n', '<leader>e', ':Neotree toggle left<CR>', { desc = 'Toggle File Explorer' })
        
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true, -- Show hidden files by default
                    hide_dotfiles = false,
                },
                follow_current_file = {
                    enabled = true, -- Focus the file you're currently editing
                },
            },
        })
    end
}
