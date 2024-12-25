vim.g.mapleader = " "
vim.g.maplocalleader = " "

local noremap_silent = { noremap = true, silent = true }

vim.keymap.set({ "i", "n" }, "<C-s>", "<Esc>:silent update!<CR>", noremap_silent) -- save file
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent) -- move selection up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent) -- move selection up
vim.keymap.set("n", "M", "gM", noremap_silent) -- Move to the middle of the line in normal mode
vim.keymap.set("n", "<C-D>", "<C-D>zz") -- Scroll down half a page and center the cursor line
vim.keymap.set("n", "<C-U>", "<C-U>zz") -- Scroll up half a page and center the cursor line
vim.keymap.set({ "n", "v" }, "H", "^") -- Move to the start of the line in normal and visual mode
vim.keymap.set({ "n", "v" }, "L", "$") -- Move to the end of the line in normal and visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- Disable the space key in normal and visual mode
vim.keymap.set("n", "S", "<nop>") -- Disable the S key in normal mode
vim.keymap.set({ "n", "v" }, "c", '"xc') -- Cut to clipboard in normal and visual mode
vim.keymap.set({ "v" }, "p", "P") -- Paste before the cursor in visual mode
vim.keymap.set("n", "<leader>a", "ggVG") -- Select all text in the file
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-w>h", { silent = true }) -- Exit terminal mode with Esc
vim.keymap.set("i", "<m-backspace>", "<C-w>") -- Delete the previous word in insert mode with Alt+Backspace
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", noremap_silent) -- Clear search highlight with Esc in normal mode
vim.keymap.set("n", "U", "<C-r>", { remap = false }) -- Use `u` to undo, use `U` to redo
vim.keymap.set("n", "n", "nzz", { remap = false }) -- Search next with n and center the cursor line
vim.keymap.set("n", "N", "Nzz", { remap = false }) -- Search previous with N and center the cursor line
vim.keymap.set("n", "*", "*zz", { remap = false }) -- Search the word under the cursor with * and center the cursor line
vim.keymap.set("n", "<C-q>", "<C-w>q", { silent = true }) -- Close the current window with Ctrl+q
vim.keymap.set("v", "'", [[<right>:s/\%V\(.*\%V\)/'\1'/ <CR>]], { desc = "Surround selection with '" }) -- Surround the visual selection with ''
vim.keymap.set("v", '"', [[<right>:s/\%V\(.*\)\%V/"\1"/ <CR>]], { desc = 'Surround selection with "' }) -- Surround the visual selection with ''
vim.keymap.set("v", "`", [[<right>:s/\%V\(.*\)\%V/`\1`/ <CR>]], { desc = "Surround selection with `" }) -- Surround the visual selection with ``
vim.keymap.set("v", "{", [[<right>:s/\%V\(.*\)\%V/{\1}/ <CR>]], { desc = "Surround selection with {" }) -- Surround the visual selection with {}
vim.keymap.set("v", "[", [[<right>:s/\%V\(.*\)\%V/[\1]/ <CR>]], { desc = "Surround selection with [" }) -- Surround the visual selection with []
vim.keymap.set("v", "(", [[<right>:s/\%V\(.*\)\%V/\(\1\)/ <CR>]], { desc = "Surround selection with [" }) -- Surround the visual selection with []
vim.keymap.set("v", "n", 'y/<C-r>"<CR>N') -- Search the visual selection
vim.keymap.set({ "n", "v", "i" }, "<C-g>", "<esc>") --

vim.keymap.set("n", "<Tab>", ":b#<CR>", { silent = true })

-- Resize window using Alt and arrow keys
vim.keymap.set("n", "<S-Left>", "<c-w>5<")
vim.keymap.set("n", "<S-Right>", "<c-w>5>")
vim.keymap.set("n", "<S-Up>", "<c-w>+")
vim.keymap.set("n", "<S-Down>", "<c-w>-")

-- keymap that deletes the current line and puts the cursor in the right place
vim.keymap.set("n", "dd", function()
	if vim.fn.getline(".") == "" then
		return '"_dd'
	end
	return "dd"
end, { expr = true })
