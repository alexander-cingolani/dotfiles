return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = 'Telescope',
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files' },
        { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Grep Project' },
        { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Find Buffers' },
        { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Help Tags' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')

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
    end
    }
