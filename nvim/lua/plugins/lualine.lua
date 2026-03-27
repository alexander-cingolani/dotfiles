local scuderia_colors = {
  base     = "#111014",
  surface  = "#1E1B1E",
  overlay  = "#2A272A",
  text     = "#E8E6EC",
  subtext  = "#9A98A8",
  muted    = "#555255",
  red      = "#CC1A20",
  red_br   = "#E02828",
  gold     = "#C89414",
  gold_br  = "#D4AA24",
  blue     = "#7A9AAA",
  teal     = "#5A8A8E",
  green    = "#5A8A65",
  orange   = "#D4780A",
}

local scuderia_theme = {
  normal = {
    a = { fg = scuderia_colors.base, bg = scuderia_colors.gold, gui = "bold" },
    b = { fg = scuderia_colors.text, bg = scuderia_colors.overlay },
    c = { fg = scuderia_colors.text, bg = scuderia_colors.surface },
  },
  insert = {
    a = { fg = scuderia_colors.base, bg = scuderia_colors.green, gui = "bold" },
    b = { fg = scuderia_colors.text, bg = scuderia_colors.overlay },
    c = { fg = scuderia_colors.text, bg = scuderia_colors.surface },
  },
  visual = {
    a = { fg = scuderia_colors.base, bg = scuderia_colors.red, gui = "bold" },
    b = { fg = scuderia_colors.text, bg = scuderia_colors.overlay },
    c = { fg = scuderia_colors.text, bg = scuderia_colors.surface },
  },
  replace = {
    a = { fg = scuderia_colors.base, bg = scuderia_colors.orange, gui = "bold" },
    b = { fg = scuderia_colors.text, bg = scuderia_colors.overlay },
    c = { fg = scuderia_colors.text, bg = scuderia_colors.surface },
  },
  command = {
    a = { fg = scuderia_colors.base, bg = scuderia_colors.blue, gui = "bold" },
    b = { fg = scuderia_colors.text, bg = scuderia_colors.overlay },
    c = { fg = scuderia_colors.text, bg = scuderia_colors.surface },
  },
  inactive = {
    a = { fg = scuderia_colors.muted, bg = scuderia_colors.surface, gui = "bold" },
    b = { fg = scuderia_colors.muted, bg = scuderia_colors.surface },
    c = { fg = scuderia_colors.muted, bg = scuderia_colors.surface },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = scuderia_theme,
      component_separators = "|",
      section_separators = "",
    },
    sections = {
      lualine_c = {
        {
          "filename",
          file_status = true,
          newfile_status = true,
          symbols = {
            modified = " [+]",
            readonly = " [-]",
            unnamed = "[No Name]",
            newfile = " [New]",
          },
        },
      },
    },
  },
}
