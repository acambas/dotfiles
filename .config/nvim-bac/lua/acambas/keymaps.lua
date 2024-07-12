vim.g.mapleader = " "
vim.g.maplocalleader = " "

local noremap_silent = { noremap = true, silent = true }

-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "open explorer" })
vim.keymap.set({ "i", "n" }, "<C-s>", "<Esc>:silent w!<CR>", noremap_silent) -- save file
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent) -- move selection up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent) -- move selection up
vim.keymap.set("n", "J", "12jzz")
vim.keymap.set("n", "K", "12kzz")
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "S", "<nop>")
vim.keymap.set({ "n", "v" }, "c", '"xc')
vim.keymap.set("n", "<leader>gq", function()
	local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
	local action = qf_winid > 0 and "cclose" or "copen"
	vim.cmd("botright " .. action)
end, { desc = "toggle quicklist", noremap = true, silent = true })
-- use `u` to undo, use `U` to redo
vim.keymap.set("n", "U", "<C-r>", { remap = false })

-- Make search results appear in the middle of the screen
vim.keymap.set("n", "n", "nzz", { remap = false })
vim.keymap.set("n", "N", "Nzz", { remap = false })
vim.keymap.set("n", "*", "*zz", { remap = false })

-- windon controlls
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-q>", "<C-w>q", { silent = true })

-- clear search
vim.api.nvim_set_keymap("n", "<esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Copy current file name (relative/absolute) to system clipboard
vim.keymap.set(
	"n",
	"<leader>fcr",
	[[ :let @*=expand("%")<CR> ]],
	{ remap = false, silent = true, desc = "copy relative path" }
)
vim.keymap.set(
	"n",
	"<leader>fca",
	[[ :let @*=expand("%:p")<CR> ]],
	{ remap = false, silent = true, desc = "copy absolute path" }
)
vim.keymap.set(
	"n",
	"<leader>fcf",
	[[ :let @*=expand("%:t")<CR> ]],
	{ remap = false, silent = true, desc = "copy file name" }
)
vim.keymap.set(
	"n",
	"<leader>fcF",
	[[ :let @*=expand("%:h")<CR> ]],
	{ remap = false, silent = true, desc = "copy relative folder path" }
)

-- keymap that deletes the current line and yank it to the system clipboard if it's not empty
vim.keymap.set("n", "dd", function()
	if vim.fn.getline(".") == "" then
		return '"_dd'
	end
	return "dd"
end, { expr = true })

table.unpack = table.unpack or unpack
local function get_visual_selection()
	local _, ls, cs = table.unpack(vim.fn.getpos("v"))
	local _, le, ce = table.unpack(vim.fn.getpos("."))
	return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

vim.keymap.set("v", "<C-r>", function()
	local pattern = table.concat(get_visual_selection())
	pattern = vim.fn.substitute(vim.fn.escape(pattern, "^$.*\\/~[]"), "\n", "\\n", "g")
	vim.api.nvim_input("<Esc>:%s/" .. pattern .. "//g<Left><Left>")
end)

if vim.g.vscode then
	-- VSCode extension
	vim.keymap.set("n", "s", "<nop>")
	vim.keymap.set("n", "Q", "<nop>")
	vim.keymap.set({ "n", "v" }, "<leader>ca", "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")
	vim.keymap.set("n", "<leader>sf", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
	vim.keymap.set("n", "gr", "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>")
	vim.keymap.set("n", "<leader>crn", "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")
else
	-- ordinary Neovim
	vim.keymap.set("n", "Q", "<Esc>:qa!<CR>", { silent = true })
	-- buffer stuff
	vim.keymap.set("n", "<tab>", "<C-S-^>")
	-- vim.keymap.set("n", "<C-q>", "<Esc>:bw!<cr>", { desc = "[q]uit buffer", silent = true, noremap = true })
	vim.keymap.set("n", "<leader>bn", "<Esc>:bnext<cr>", { desc = "buffer [n]ext", silent = true, noremap = true })
	vim.keymap.set("n", "<leader>bp", "<Esc>:bprev<cr>", { desc = "buffer [p]revious", silent = true, noremap = true })
	vim.keymap.set("n", "<leader>bq", "<Esc>:bw!<cr>", { desc = "[q]uit buffer", silent = true, noremap = true })
	-- editor.action.quickFix
	-- Resize windows with arrow keys
	vim.keymap.set({ "n", "t" }, "<m-Left>", "<C-w><", { remap = false })
	vim.keymap.set({ "n", "t" }, "<m-Right>", "<C-w>>", { remap = false })
	vim.keymap.set({ "n", "t" }, "<m-Up>", "<C-w>-", { remap = false })
	vim.keymap.set({ "n", "t" }, "<m-Down>", "<C-w>+", { remap = false })
end
