require("acambas.keymaps")
require("acambas.lazy")

-- fold settings
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- misc settings
vim.opt.autoread = true -- Auto refresh if the file has been changed outside of VIM

vim.opt.cmdheight = 0
vim.opt.statusline = "%f - %y %=%S %l %L"
vim.opt.showcmdloc = "statusline"
-- Set highlight on search
vim.o.hlsearch = true
vim.opt.incsearch = true

-- Make line numbers default
vim.opt.number = true
vim.wo.relativenumber = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 200

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Indentation
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- this command places the cursor in the last position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

vim.o.termguicolors = true
vim.cmd("colorscheme cyberdream")

vim.api.nvim_create_user_command("Finder", function()
	local path = vim.api.nvim_buf_get_name(0)
	os.execute("open -R " .. path)
end, {})

vim.api.nvim_create_user_command("PathCopyRel", function()
	local path = require("plenary").path:new(vim.api.nvim_buf_get_name(0)):make_relative()
	-- log the path
	if vim.bo.filetype == "oil" then
		local oil = require("oil")
		path = require("plenary").path:new(oil.get_current_dir()):make_relative()
	end
	vim.fn.setreg("+", path)
end, {}) -- copy relative path

-- vim.api.nvim_create_user_command('PathCopyAbs', function()
--   local path = vim.api.nvim_buf_get_name(0)
--   -- log the path
--   if vim.bo.filetype == 'oil' then
--     local oil = require("oil")
--     path = oil.get_current_dir()
--   end
--   vim.fn.setreg('+', path)
-- end, {}) -- absolute path
