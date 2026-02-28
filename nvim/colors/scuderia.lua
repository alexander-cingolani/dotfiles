vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.g.colors_name = "scuderia"
vim.o.background = "dark"

local c = {
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

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hi("Normal",         { fg = c.text,    bg = c.base })
hi("NormalFloat",    { fg = c.text,    bg = c.surface })
hi("NormalNC",       { fg = c.subtext, bg = c.base })
hi("SignColumn",     { fg = c.muted,   bg = c.base })
hi("LineNr",         { fg = c.muted,   bg = c.base })
hi("CursorLineNr",   { fg = c.gold,    bg = c.base, bold = true })
hi("CursorLine",     { bg = c.surface })
hi("ColorColumn",    { bg = c.surface })
hi("Visual",         { bg = c.overlay })
hi("Pmenu",          { fg = c.text,    bg = c.surface })
hi("PmenuSel",       { fg = c.base,    bg = c.gold })
hi("PmenuSbar",      { bg = c.overlay })
hi("PmenuThumb",     { bg = c.muted })
hi("StatusLine",     { fg = c.text,    bg = c.surface })
hi("StatusLineNC",   { fg = c.muted,   bg = c.surface })
hi("TabLine",        { fg = c.subtext, bg = c.surface })
hi("TabLineSel",     { fg = c.text,    bg = c.base, bold = true })
hi("TabLineFill",    { bg = c.surface })
hi("WinSeparator",   { fg = c.overlay, bg = c.base })
hi("Folded",         { fg = c.subtext, bg = c.surface })
hi("EndOfBuffer",    { fg = c.muted })
hi("MatchParen",     { fg = c.gold, bold = true, underline = true })
hi("Search",         { fg = c.base,    bg = c.gold })
hi("IncSearch",      { fg = c.base,    bg = c.red })
hi("CurSearch",      { fg = c.base,    bg = c.red })
hi("NonText",        { fg = c.muted })
hi("Whitespace",     { fg = c.overlay })
hi("Directory",      { fg = c.blue })
hi("Title",          { fg = c.gold, bold = true })
hi("WarningMsg",     { fg = c.orange })
hi("ErrorMsg",       { fg = c.red })
hi("Cursor",         { fg = c.base,    bg = c.gold })

-- Syntax
hi("Comment",        { fg = c.muted,   italic = true })
hi("String",         { fg = c.teal })
hi("Character",      { fg = c.teal })
hi("Number",         { fg = c.gold })
hi("Float",          { fg = c.gold })
hi("Boolean",        { fg = c.red })
hi("Constant",       { fg = c.gold })
hi("Identifier",     { fg = c.text })
hi("Function",       { fg = c.blue })
hi("Keyword",        { fg = c.red, bold = true })
hi("Conditional",    { fg = c.red })
hi("Repeat",         { fg = c.red })
hi("Operator",       { fg = c.subtext })
hi("Type",           { fg = c.gold_br })
hi("StorageClass",   { fg = c.gold })
hi("Structure",      { fg = c.gold })
hi("Typedef",        { fg = c.gold })
hi("PreProc",        { fg = c.gold })
hi("Include",        { fg = c.gold })
hi("Macro",          { fg = c.gold })
hi("Special",        { fg = c.teal })
hi("Delimiter",      { fg = c.subtext })
hi("Error",          { fg = c.red })
hi("Todo",           { fg = c.base, bg = c.gold, bold = true })
hi("Underlined",     { underline = true })

-- Treesitter
hi("@variable",              { fg = c.text })
hi("@variable.builtin",      { fg = c.red })
hi("@variable.parameter",    { fg = c.text, italic = true })
hi("@variable.member",       { fg = c.blue })
hi("@constant",              { fg = c.gold })
hi("@constant.builtin",      { fg = c.gold, bold = true })
hi("@string",                { fg = c.teal })
hi("@string.escape",         { fg = c.red })
hi("@number",                { fg = c.gold })
hi("@boolean",               { fg = c.red })
hi("@function",              { fg = c.blue })
hi("@function.builtin",      { fg = c.blue, bold = true })
hi("@function.call",         { fg = c.blue })
hi("@function.method",       { fg = c.blue })
hi("@constructor",           { fg = c.gold })
hi("@operator",              { fg = c.subtext })
hi("@keyword",               { fg = c.red, bold = true })
hi("@keyword.function",      { fg = c.red, bold = true })
hi("@keyword.return",        { fg = c.red, bold = true })
hi("@keyword.import",        { fg = c.gold })
hi("@type",                  { fg = c.gold_br })
hi("@type.builtin",          { fg = c.gold_br, italic = true })
hi("@property",              { fg = c.blue })
hi("@attribute",             { fg = c.gold })
hi("@punctuation.delimiter", { fg = c.subtext })
hi("@punctuation.bracket",   { fg = c.subtext })
hi("@comment",               { fg = c.muted, italic = true })
hi("@comment.todo",          { fg = c.base, bg = c.gold, bold = true })
hi("@tag",                   { fg = c.red })
hi("@tag.attribute",         { fg = c.gold })
hi("@tag.delimiter",         { fg = c.subtext })

-- LSP Diagnostics
hi("DiagnosticError",          { fg = c.red })
hi("DiagnosticWarn",           { fg = c.orange })
hi("DiagnosticInfo",           { fg = c.blue })
hi("DiagnosticHint",           { fg = c.teal })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.orange })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = c.teal })
hi("LspReferenceText",         { bg = c.overlay })
hi("LspReferenceRead",         { bg = c.overlay })
hi("LspReferenceWrite",        { bg = c.overlay, bold = true })

-- Telescope
hi("TelescopeBorder",       { fg = c.overlay, bg = c.surface })
hi("TelescopeNormal",       { fg = c.text,    bg = c.surface })
hi("TelescopePromptBorder", { fg = c.gold,    bg = c.surface })
hi("TelescopeResultsTitle", { fg = c.gold,    bold = true })
hi("TelescopePreviewTitle", { fg = c.teal,    bold = true })
hi("TelescopeSelection",    { bg = c.overlay })
hi("TelescopeMatching",     { fg = c.gold,    bold = true })

-- nvim-tree
hi("NvimTreeNormal",           { fg = c.text,   bg = c.surface })
hi("NvimTreeFolderName",       { fg = c.blue })
hi("NvimTreeOpenedFolderName", { fg = c.gold })
hi("NvimTreeRootFolder",       { fg = c.red,    bold = true })
hi("NvimTreeGitDirty",         { fg = c.orange })
hi("NvimTreeGitNew",           { fg = c.green })
hi("NvimTreeGitDeleted",       { fg = c.red })

-- GitSigns
hi("GitSignsAdd",    { fg = c.green })
hi("GitSignsChange", { fg = c.gold })
hi("GitSignsDelete", { fg = c.red })
