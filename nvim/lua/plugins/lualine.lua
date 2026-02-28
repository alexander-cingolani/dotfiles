local scuderia = {
  normal = {
    a = { fg = "#111014", bg = "#CC1A20", gui = "bold" },
    b = { fg = "#E8E6EC", bg = "#2A272A" },
    c = { fg = "#9A98A8", bg = "#1E1B1E" },
  },
  insert = {
    a = { fg = "#111014", bg = "#C89414", gui = "bold" },
    b = { fg = "#E8E6EC", bg = "#2A272A" },
    c = { fg = "#9A98A8", bg = "#1E1B1E" },
  },
  visual = {
    a = { fg = "#111014", bg = "#7A9AAA", gui = "bold" },
    b = { fg = "#E8E6EC", bg = "#2A272A" },
    c = { fg = "#9A98A8", bg = "#1E1B1E" },
  },
  replace = {
    a = { fg = "#111014", bg = "#D4780A", gui = "bold" },
    b = { fg = "#E8E6EC", bg = "#2A272A" },
    c = { fg = "#9A98A8", bg = "#1E1B1E" },
  },
  command = {
    a = { fg = "#111014", bg = "#5A8A65", gui = "bold" },
    b = { fg = "#E8E6EC", bg = "#2A272A" },
    c = { fg = "#9A98A8", bg = "#1E1B1E" },
  },
  inactive = {
    a = { fg = "#555255", bg = "#1E1B1E" },
    b = { fg = "#555255", bg = "#1E1B1E" },
    c = { fg = "#555255", bg = "#1E1B1E" },
  },
}


return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = scuderia,
      component_separators = '|',
      section_separators = '',
    },
  }
}

