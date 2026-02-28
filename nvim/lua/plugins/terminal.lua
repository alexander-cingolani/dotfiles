return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        open_mapping = [[<C-\>]], -- Press Ctrl + \ to toggle
        direction = 'horizontal',      -- Can be 'horizontal', 'vertical', or 'float'
        shade_terminals = true,
        float_opts = {
            border = 'curved',
        },
    }
}
