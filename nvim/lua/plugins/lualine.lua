return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto', -- Automatically matches your current colorscheme
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true,
          newfile_status = true,
          symbols = {
            modified = ' [+]',
            readonly = ' [-]',
            unnamed = '[No Name]',
            newfile = ' [New]',
          },
        },
      },
    },
  }
}
