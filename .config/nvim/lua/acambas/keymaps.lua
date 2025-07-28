-- ============================================================================
-- LEADER KEYS
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Common options
local noremap_silent = { noremap = true, silent = true }

-- ============================================================================
-- DISABLED KEYS
-- ============================================================================
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "S", "<nop>")

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================
vim.keymap.set({ "i", "n" }, "<C-s>", "<Esc>:silent update!<CR>", noremap_silent)

-- ============================================================================
-- MOVEMENT AND NAVIGATION
-- ============================================================================
-- Enhanced line movement
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$h")
vim.keymap.set("n", "M", "gM", noremap_silent)

-- Centered scrolling
vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- Buffer navigation
vim.keymap.set("n", "<C-t>", ":b#<CR>", { silent = true })

-- ============================================================================
-- SEARCH AND REPLACE
-- ============================================================================
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", noremap_silent)
vim.keymap.set("n", "n", "nzz", { remap = false })
vim.keymap.set("n", "N", "Nzz", { remap = false })
vim.keymap.set("n", "*", "*zz", { remap = false })
vim.keymap.set("v", "n", 'y/<C-r>"<CR>N')

-- Visual selection search and replace
table.unpack = table.unpack or unpack
local function get_visual()
	local _, ls, cs = table.unpack(vim.fn.getpos("v"))
	local _, le, ce = table.unpack(vim.fn.getpos("."))
	return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

vim.keymap.set("v", "<C-r>", function()
	local pattern = table.concat(get_visual())
	pattern = vim.fn.substitute(vim.fn.escape(pattern, "^$.*\\/~[]"), "\n", "\\n", "g")
	vim.api.nvim_input("<Esc>:%s/" .. pattern .. "/" .. pattern .. "/gc<Left><Left><Left>")
end)

-- ============================================================================
-- TEXT MANIPULATION
-- ============================================================================
-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent)

-- Selection and clipboard
vim.keymap.set("n", "ga", "ggVG")
vim.keymap.set({ "n", "v" }, "c", '"xc')
vim.keymap.set("v", "p", "P")

-- Undo/Redo
vim.keymap.set("n", "U", "<C-r>", { remap = false })

-- Smart line deletion
vim.keymap.set("n", "dd", function()
	if vim.fn.getline(".") == "" then
		return '"_dd'
	end
	return "dd"
end, { expr = true })

-- ============================================================================
-- SURROUND OPERATIONS
-- ============================================================================
vim.keymap.set("v", "'", [[<right>:s/\%V\(.*\%V\)/'\1'/ <CR>]], { desc = "Surround with single quotes" })
vim.keymap.set("v", '"', [[<right>:s/\%V\(.*\)\%V/"\1"/ <CR>]], { desc = "Surround with double quotes" })
vim.keymap.set("v", "`", [[<right>:s/\%V\(.*\)\%V/`\1`/ <CR>]], { desc = "Surround with backticks" })
vim.keymap.set("v", "{", [[<right>:s/\%V\(.*\)\%V/{\1}/ <CR>]], { desc = "Surround with curly braces" })
vim.keymap.set("v", "[", [[<right>:s/\%V\(.*\)\%V/[\1]/ <CR>]], { desc = "Surround with square brackets" })
vim.keymap.set("v", "(", [[<right>:s/\%V\(.*\)\%V/\(\1\)/ <CR>]], { desc = "Surround with parentheses" })

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
vim.keymap.set("n", "<C-q>", "<C-w>q", { silent = true })

-- Window resizing
vim.keymap.set("n", "<S-Left>", "<c-w>5<")
vim.keymap.set("n", "<S-Right>", "<c-w>5>")
vim.keymap.set("n", "<S-Up>", "<c-w>+")
vim.keymap.set("n", "<S-Down>", "<c-w>-")

-- ============================================================================
-- TERMINAL MODE
-- ============================================================================
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<M-Esc>", "<C-\\><C-n>", { silent = true })

-- ============================================================================
-- INSERT MODE ENHANCEMENTS
-- ============================================================================
vim.keymap.set("i", "<m-backspace>", "<C-w>")
