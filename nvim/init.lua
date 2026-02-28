-- 1. VISUAL BASICS
-- ==========================================
vim.opt.number = true
vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")
vim.opt.relativenumber = true
vim.cmd.colorscheme("scuderia")

-- 2. INDENTATION
-- ==========================================
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 3. SEARCH & UX
-- ==========================================
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- 4. BASIC KEYBINDS
-- ==========================================

vim.keymap.set("n", "<leader>p", function()
  vim.fn.jobstart({ "xdg-open", vim.fn.expand("%:p") })
end, { desc = "Open file in browser" })

-- 5. 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.loop or vim.uv).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    spec = {
	{import = "plugins" },
    },
    rocks = {
        hererocks = false,
    }
})

