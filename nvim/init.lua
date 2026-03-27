-- 1. VISUAL BASICS
-- ==========================================
vim.opt.number = true
vim.opt.termguicolors = true
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
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 4. AUTOCOMMANDS
-- ==========================================

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" then
			vim.api.nvim_command("silent! update")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.loop or vim.uv).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	rocks = {
		hererocks = false,
	},
})
