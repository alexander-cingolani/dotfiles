return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = 'Telescope',
    keys = {
        { '<leader>ff', desc = 'Find Files' },
        { '<leader>fg', desc = 'Grep Project' },
        { '<leader>fb', desc = 'Find Buffers' },
        { '<leader>fh', desc = 'Help Tags' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        })
        telescope.load_extension('fzf')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Grep Project' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
    end
}
