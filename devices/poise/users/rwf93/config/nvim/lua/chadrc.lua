-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

vim.opt.expandtab = false
vim.opt.shiftwidth = 8
vim.opt.smartindent = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 8

return M
