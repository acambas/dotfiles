-- Load core modules
require("acambas.keymaps")
require("acambas.lazy")

-- ============================================================================
-- DISPLAY AND UI SETTINGS
-- ============================================================================
vim.opt.number = true
vim.wo.relativenumber = true
vim.o.termguicolors = true
vim.opt.cmdheight = 0
vim.opt.statusline = "%f - %y %=%S %l %L"
vim.opt.showcmdloc = "statusline"

-- ============================================================================
-- SEARCH SETTINGS
-- ============================================================================
vim.o.hlsearch = true
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- ============================================================================
-- INDENTATION AND FORMATTING
-- ============================================================================
vim.o.winborder = "rounded"
vim.opt.wrap = false
vim.opt.smartindent = true
vim.o.breakindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- ============================================================================
-- FOLDING SETTINGS
-- ============================================================================
vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

-- ============================================================================
-- FILE AND BACKUP SETTINGS
-- ============================================================================
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- ============================================================================
-- PERFORMANCE SETTINGS
-- ============================================================================
vim.o.updatetime = 50
vim.o.timeoutlen = 200

-- ============================================================================
-- COMPLETION AND CLIPBOARD
-- ============================================================================
vim.o.completeopt = "menuone,noselect"
vim.o.clipboard = "unnamedplus"
-- ============================================================================
-- COLORSCHEME
-- ============================================================================
vim.cmd("colorscheme rose-pine-moon")

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

-- ============================================================================
-- CUSTOM COMMANDS
-- ============================================================================
vim.api.nvim_create_user_command("Finder", function()
	local path = vim.api.nvim_buf_get_name(0)
	os.execute("open -R " .. path)
end, {})

vim.api.nvim_create_user_command("PathCopyRel", function()
	local path = require("plenary").path:new(vim.api.nvim_buf_get_name(0)):make_relative()
	if vim.bo.filetype == "oil" then
		local oil = require("oil")
		path = require("plenary").path:new(oil.get_current_dir()):make_relative()
	end
	vim.fn.setreg("+", path)
	print("Path: " .. path)
end, {})

vim.api.nvim_create_user_command("PathCopyAbs", function()
	local path = vim.api.nvim_buf_get_name(0)
	if vim.bo.filetype == "oil" then
		local oil = require("oil")
		path = oil.get_current_dir()
	end
	print("Path: " .. path)
	vim.fn.setreg("+", path)
end, {})
